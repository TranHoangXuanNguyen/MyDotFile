#!/bin/bash
# ==============================================================================
# 🚀 ADVANCED DOTFILES INSTALLER
# Inspired by JaKooLit's Arch-Hyprland setup
# ==============================================================================

# ------------------------------------------------------
# Colors for UI
# ------------------------------------------------------
CR="\e[0;31m"
CG="\e[0;32m"
CY="\e[0;33m"
CB="\e[0;34m"
CC="\e[0;36m"
C0="\e[0m"
BOLD="\e[1m"

# Prefixes
OK="[${CG}${BOLD} OK ${C0}]"
ERR="[${CR}${BOLD} ERROR ${C0}]"
NOTE="[${CC}${BOLD} NOTE ${C0}]"
WARN="[${CY}${BOLD} WARN ${C0}]"
ACT="[${CB}${BOLD} ACTION ${C0}]"

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$HOME/.config"
BACKUP_DIR="$HOME/.config/cfg_backups/backup_$(date +%Y%m%d_%H%M%S)"

clear
echo -e "${CB}${BOLD}"
echo "  _   _                  _                 _ "
echo " | | | |_   _ _ __  _ __| | __ _ _ __   __| |"
echo " | |_| | | | | '_ \| '__| |/ _\` | '_ \ / _\` |"
echo " |  _  | |_| | |_) | |  | | (_| | | | | (_| |"
echo " |_| |_|\__, | .__/|_|  |_|\__,_|_| |_|\__,_|"
echo "        |___/|_|                             "
echo -e "${C0}"
echo -e "${CC}Welcome to the Automated Dotfiles Installer!${C0}"
echo -e "${NOTE} This script will help you set up your system quickly.\n"

sleep 1

# ------------------------------------------------------
# 1. Check and Install Yay (AUR Helper)
# ------------------------------------------------------
install_yay() {
    if command -v yay &> /dev/null; then
        echo -e "${OK} Yay is already installed."
    else
        echo -e "${WARN} Yay is not installed. Installing yay now..."
        sudo pacman -S --needed --noconfirm base-devel git
        git clone https://aur.archlinux.org/yay-bin.git /tmp/yay-bin
        cd /tmp/yay-bin && makepkg -si --noconfirm
        cd "$DOTFILES_DIR"
        echo -e "${OK} Yay installed successfully!"
    fi
}

# ------------------------------------------------------
# 2. Install Packages
# ------------------------------------------------------
echo -e "${ACT} Do you want to install the required system packages? (y/n)"
read -p ">> " INST_PKG

if [[ "$INST_PKG" =~ ^[Yy]$ ]]; then
    echo -e "\n${NOTE} Synchronizing pacman databases..."
    sudo pacman -Sy
    
    echo -e "\n${ACT} Installing packages from Pacman..."
    sudo pacman -S --needed - < "$DOTFILES_DIR/packages-pacman.txt"
    
    install_yay
    
    echo -e "\n${ACT} Installing packages from AUR..."
    yay -S --needed - < "$DOTFILES_DIR/packages-aur.txt"
    
    echo -e "${OK} Package installation complete!"
else
    echo -e "${NOTE} Skipping package installation."
fi

# ------------------------------------------------------
# 3. Manage Configurations (Backup & Symlink)
# ------------------------------------------------------
echo -e "\n${ACT} Starting configuration setup..."
mkdir -p "$BACKUP_DIR"

# Loop through all items in the configs directory
for item in "$DOTFILES_DIR/configs/"*; do
    if [ -d "$item" ] || [ -f "$item" ]; then
        target_name=$(basename "$item")
        target_path="$CONFIG_DIR/$target_name"

        # Backup if it already exists
        if [ -e "$target_path" ] || [ -L "$target_path" ]; then
            echo -e "${NOTE} Found existing config for ${CY}$target_name${C0}. Backing up..."
            mv "$target_path" "$BACKUP_DIR/"
        fi
        
        # Symlink
        echo -e "${OK} Symlinking: ${CG}$target_name${C0}"
        ln -s "$item" "$target_path"
    fi
done

echo -e "\n${OK} ${CG}${BOLD}INSTALLATION SUCCESSFUL!${C0}"
echo -e "${NOTE} Your old configurations have been backed up to: ${CY}$BACKUP_DIR${C0}"
echo -e "${NOTE} Please reboot your system to apply all changes.\n"
