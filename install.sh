#!/usr/bin/env bash

# ==============================================================================
# ADVANCED DOTFILES INSTALLER
# Arch Linux + Hyprland
#
# Repository structure:
#
# dotfiles/
# ├── install.sh
# ├── packages-pacman.txt
# ├── packages-aur.txt
# ├── configs/
# │   ├── hypr/
# │   ├── kitty/
# │   ├── waybar/
# │   ├── rofi/
# │   ├── swaync/
# │   └── nvim/
# └── home/
#     ├── .zshrc
#     ├── .gitconfig
#     └── ...
# ==============================================================================

set -Eeuo pipefail

# ------------------------------------------------------------------------------
# Colors
# ------------------------------------------------------------------------------

CR="\033[0;31m"
CG="\033[0;32m"
CY="\033[0;33m"
CB="\033[0;34m"
CC="\033[0;36m"
C0="\033[0m"
BOLD="\033[1m"

OK="[${CG}${BOLD} OK ${C0}]"
ERR="[${CR}${BOLD} ERROR ${C0}]"
NOTE="[${CC}${BOLD} NOTE ${C0}]"
WARN="[${CY}${BOLD} WARN ${C0}]"
ACT="[${CB}${BOLD} ACTION ${C0}]"

# ------------------------------------------------------------------------------
# Paths
# ------------------------------------------------------------------------------

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

CONFIG_SOURCE_DIR="$SCRIPT_DIR/configs"
HOME_SOURCE_DIR="$SCRIPT_DIR/home"

CONFIG_DIR="$HOME/.config"
BACKUP_ROOT="$HOME/.config/cfg_backups"
BACKUP_DIR="$BACKUP_ROOT/backup_$(date +%Y%m%d_%H%M%S)"

PACMAN_FILE="$SCRIPT_DIR/packages-pacman.txt"
AUR_FILE="$SCRIPT_DIR/packages-aur.txt"

BACKUP_CREATED=false

# ------------------------------------------------------------------------------
# Error handling
# ------------------------------------------------------------------------------

error_handler() {
    local exit_code=$?
    local line_number=${1:-unknown}

    printf "\n%b Installation failed at line %s with exit code %s.%b\n" \
        "$ERR" "$line_number" "$exit_code" "$C0"

    if [[ "$BACKUP_CREATED" == true ]]; then
        printf "%b Existing configurations were backed up to:\n%s\n" \
            "$NOTE" "$BACKUP_DIR"
    fi

    exit "$exit_code"
}

trap 'error_handler "$LINENO"' ERR

# ------------------------------------------------------------------------------
# Helper functions
# ------------------------------------------------------------------------------

print_header() {
    clear

    printf "%b%b" "$CB" "$BOLD"

    cat <<'EOF'
  _   _                  _                 _
 | | | |_   _ _ __  _ __| | __ _ _ __   __| |
 | |_| | | | | '_ \| '__| |/ _` | '_ \ / _` |
 |  _  | |_| | |_) | |  | | (_| | | | | (_| |
 |_| |_|\__, | .__/|_|  |_|\__,_|_| |_|\__,_|
        |___/|_|
EOF

    printf "%b\n" "$C0"
    printf "%bWelcome to the Automated Dotfiles Installer!%b\n" "$CC" "$C0"
    printf "%b This script installs packages and links your configurations.%b\n\n" \
        "$NOTE" "$C0"
}

confirm() {
    local prompt="$1"
    local answer

    while true; do
        printf "%b %s [y/N]: %b" "$ACT" "$prompt" "$C0"
        read -r answer

        case "$answer" in
            [Yy]|[Yy][Ee][Ss])
                return 0
                ;;
            ""|[Nn]|[Nn][Oo])
                return 1
                ;;
            *)
                printf "%b Please enter y or n.%b\n" "$WARN" "$C0"
                ;;
        esac
    done
}

require_command() {
    local command_name="$1"

    if ! command -v "$command_name" >/dev/null 2>&1; then
        printf "%b Required command not found: %s%b\n" \
            "$ERR" "$command_name" "$C0"
        exit 1
    fi
}

ensure_not_root() {
    if [[ "$EUID" -eq 0 ]]; then
        printf "%b Do not run this script as root.%b\n" "$ERR" "$C0"
        printf "%b Run it as your normal user. The script uses sudo when required.%b\n" \
            "$NOTE" "$C0"
        exit 1
    fi
}

create_backup_dir() {
    if [[ "$BACKUP_CREATED" == false ]]; then
        mkdir -p "$BACKUP_DIR"
        BACKUP_CREATED=true
    fi
}

read_package_file() {
    local package_file="$1"
    local -n output_array="$2"

    output_array=()

    if [[ ! -f "$package_file" ]]; then
        printf "%b Package file not found: %s%b\n" \
            "$WARN" "$package_file" "$C0"
        return 0
    fi

    mapfile -t output_array < <(
        sed \
            -e 's/[[:space:]]*#.*$//' \
            -e '/^[[:space:]]*$/d' \
            "$package_file"
    )
}

backup_existing_target() {
    local target="$1"
    local target_name="$2"

    create_backup_dir

    local backup_target="$BACKUP_DIR/$target_name"

    if [[ -e "$backup_target" || -L "$backup_target" ]]; then
        backup_target="${backup_target}_$(date +%H%M%S%N)"
    fi

    printf "%b Backing up: %s%b\n" "$NOTE" "$target" "$C0"
    mv -- "$target" "$backup_target"
}

create_symlink() {
    local source="$1"
    local target="$2"
    local target_name="$3"

    if [[ ! -e "$source" && ! -L "$source" ]]; then
        printf "%b Source does not exist: %s%b\n" "$WARN" "$source" "$C0"
        return 0
    fi

    # Symlink already points to the correct source.
    if [[ -L "$target" ]]; then
        local current_source
        current_source="$(readlink -f -- "$target" 2>/dev/null || true)"

        if [[ "$current_source" == "$(readlink -f -- "$source")" ]]; then
            printf "%b Already linked: %s%b\n" "$OK" "$target_name" "$C0"
            return 0
        fi
    fi

    # Existing file, directory, or broken symlink.
    if [[ -e "$target" || -L "$target" ]]; then
        backup_existing_target "$target" "$target_name"
    fi

    mkdir -p "$(dirname -- "$target")"

    ln -s -- "$source" "$target"

    printf "%b Linked: %s -> %s%b\n" \
        "$OK" "$target" "$source" "$C0"
}

# ------------------------------------------------------------------------------
# Install yay
# ------------------------------------------------------------------------------

install_yay() {
    if command -v yay >/dev/null 2>&1; then
        printf "%b yay is already installed.%b\n" "$OK" "$C0"
        return 0
    fi

    printf "%b Installing yay-bin...%b\n" "$ACT" "$C0"

    sudo pacman -S --needed --noconfirm base-devel git

    local temporary_directory
    temporary_directory="$(mktemp -d)"

    cleanup_yay_temp() {
        rm -rf -- "$temporary_directory"
    }

    trap cleanup_yay_temp RETURN

    git clone https://aur.archlinux.org/yay-bin.git \
        "$temporary_directory/yay-bin"

    (
        cd "$temporary_directory/yay-bin"
        makepkg -si --noconfirm
    )

    printf "%b yay installed successfully.%b\n" "$OK" "$C0"
}

# ------------------------------------------------------------------------------
# Install packages
# ------------------------------------------------------------------------------

install_packages() {
    local pacman_packages=()
    local aur_packages=()

    read_package_file "$PACMAN_FILE" pacman_packages
    read_package_file "$AUR_FILE" aur_packages

    printf "%b Updating the Arch Linux system...%b\n" "$ACT" "$C0"
    sudo pacman -Syu --noconfirm

    if (( ${#pacman_packages[@]} > 0 )); then
        printf "%b Installing %d official packages...%b\n" \
            "$ACT" "${#pacman_packages[@]}" "$C0"

        sudo pacman -S --needed --noconfirm "${pacman_packages[@]}"
    else
        printf "%b No official packages found.%b\n" "$NOTE" "$C0"
    fi

    if (( ${#aur_packages[@]} > 0 )); then
        install_yay

        printf "%b Installing %d AUR packages...%b\n" \
            "$ACT" "${#aur_packages[@]}" "$C0"

        yay -S --needed --noconfirm "${aur_packages[@]}"
    else
        printf "%b No AUR packages found.%b\n" "$NOTE" "$C0"
    fi

    printf "%b Package installation completed.%b\n" "$OK" "$C0"
}

# ------------------------------------------------------------------------------
# Link ~/.config items
# ------------------------------------------------------------------------------

link_config_files() {
    printf "\n%b Linking application configurations...%b\n" "$ACT" "$C0"

    mkdir -p "$CONFIG_DIR"

    if [[ ! -d "$CONFIG_SOURCE_DIR" ]]; then
        printf "%b Config directory not found: %s%b\n" \
            "$WARN" "$CONFIG_SOURCE_DIR" "$C0"
        return 0
    fi

    shopt -s nullglob dotglob

    local config_items=("$CONFIG_SOURCE_DIR"/*)

    if (( ${#config_items[@]} == 0 )); then
        printf "%b No configuration files found in %s.%b\n" \
            "$WARN" "$CONFIG_SOURCE_DIR" "$C0"

        shopt -u nullglob dotglob
        return 0
    fi

    local item
    local target_name
    local target_path

    for item in "${config_items[@]}"; do
        target_name="$(basename -- "$item")"
        target_path="$CONFIG_DIR/$target_name"

        create_symlink "$item" "$target_path" "$target_name"
    done

    shopt -u nullglob dotglob
}

# ------------------------------------------------------------------------------
# Link files directly into $HOME
# ------------------------------------------------------------------------------

link_home_files() {
    printf "\n%b Linking home-directory dotfiles...%b\n" "$ACT" "$C0"

    if [[ ! -d "$HOME_SOURCE_DIR" ]]; then
        printf "%b Home dotfiles directory does not exist. Skipping.%b\n" \
            "$NOTE" "$C0"
        return 0
    fi

    shopt -s nullglob dotglob

    local home_items=("$HOME_SOURCE_DIR"/*)

    if (( ${#home_items[@]} == 0 )); then
        printf "%b No home dotfiles found in %s.%b\n" \
            "$NOTE" "$HOME_SOURCE_DIR" "$C0"

        shopt -u nullglob dotglob
        return 0
    fi

    local item
    local target_name
    local target_path
    local backup_name

    for item in "${home_items[@]}"; do
        target_name="$(basename -- "$item")"
        target_path="$HOME/$target_name"

        # Avoid hidden names being awkward inside the backup directory.
        backup_name="home_${target_name#.}"

        create_symlink "$item" "$target_path" "$backup_name"
    done

    shopt -u nullglob dotglob
}

# ------------------------------------------------------------------------------
# Show summary
# ------------------------------------------------------------------------------

show_summary() {
    printf "\n%b%b INSTALLATION COMPLETED %b\n\n" "$CG" "$BOLD" "$C0"

    printf "%b Dotfiles source:%b\n" "$NOTE" "$C0"
    printf "  %s\n\n" "$SCRIPT_DIR"

    if [[ "$BACKUP_CREATED" == true ]]; then
        printf "%b Existing files were backed up to:%b\n" "$NOTE" "$C0"
        printf "  %s\n\n" "$BACKUP_DIR"
    else
        printf "%b No existing configuration needed to be backed up.%b\n\n" \
            "$NOTE" "$C0"
    fi

    printf "%b Recommended next steps:%b\n" "$NOTE" "$C0"
    printf "  1. Review the generated symlinks.\n"
    printf "  2. Restart Waybar, Swaync, and Hyprland if necessary.\n"
    printf "  3. Log out or reboot to apply all session-level changes.\n\n"

    printf "%b Useful commands:%b\n" "$NOTE" "$C0"
    printf "  find ~/.config -maxdepth 1 -type l -ls\n"
    printf "  find ~ -maxdepth 1 -type l -ls\n"
}

# ------------------------------------------------------------------------------
# Main
# ------------------------------------------------------------------------------

main() {
    ensure_not_root

    require_command sudo
    require_command pacman
    require_command git
    require_command readlink

    print_header

    printf "%b Dotfiles directory: %s%b\n\n" \
        "$NOTE" "$SCRIPT_DIR" "$C0"

    if confirm "Install and update required packages?"; then
        install_packages
    else
        printf "%b Skipping package installation.%b\n" "$NOTE" "$C0"
    fi

    if confirm "Link application configurations into ~/.config?"; then
        link_config_files
    else
        printf "%b Skipping ~/.config symlinks.%b\n" "$NOTE" "$C0"
    fi

    if confirm "Link shell and home dotfiles into ~/?"; then
        link_home_files
    else
        printf "%b Skipping home-directory symlinks.%b\n" "$NOTE" "$C0"
    fi

    show_summary
}

main "$@"
