#!/bin/bash
# ==============================================================================
# 🚀 ADVANCED DOTFILES INSTALLER
# Inspired by JaKooLit's Arch-Hyprland setup
# ==============================================================================

# ------------------------------------------------------
# Màu sắc (Colors for UI)
# ------------------------------------------------------
CR="\e[0;31m"
CG="\e[0;32m"
CY="\e[0;33m"
CB="\e[0;34m"
CC="\e[0;36m"
C0="\e[0m"
BOLD="\e[1m"

# Tiền tố (Prefixes)
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
echo -e "${CC}Chào mừng đến với trình cài đặt Dotfiles tự động!${C0}"
echo -e "${NOTE} Script này sẽ giúp bạn thiết lập hệ thống nhanh chóng.\n"

sleep 1

# ------------------------------------------------------
# 1. Hàm kiểm tra và cài đặt Yay (AUR Helper)
# ------------------------------------------------------
install_yay() {
    if command -v yay &> /dev/null; then
        echo -e "${OK} Yay đã được cài đặt."
    else
        echo -e "${WARN} Yay chưa được cài đặt. Đang tiến hành cài đặt yay..."
        sudo pacman -S --needed --noconfirm base-devel git
        git clone https://aur.archlinux.org/yay-bin.git /tmp/yay-bin
        cd /tmp/yay-bin && makepkg -si --noconfirm
        cd "$DOTFILES_DIR"
        echo -e "${OK} Cài đặt Yay thành công!"
    fi
}

# ------------------------------------------------------
# 2. Cài đặt Packages
# ------------------------------------------------------
echo -e "${ACT} Bạn có muốn cài đặt các gói phần mềm hệ thống không? (y/n)"
read -p ">> " INST_PKG

if [[ "$INST_PKG" =~ ^[Yy]$ ]]; then
    echo -e "\n${NOTE} Đang đồng bộ kho lưu trữ pacman..."
    sudo pacman -Sy
    
    echo -e "\n${ACT} Đang cài đặt các gói từ Pacman..."
    sudo pacman -S --needed - < "$DOTFILES_DIR/packages-pacman.txt"
    
    install_yay
    
    echo -e "\n${ACT} Đang cài đặt các gói từ AUR..."
    yay -S --needed - < "$DOTFILES_DIR/packages-aur.txt"
    
    echo -e "${OK} Hoàn tất cài đặt phần mềm!"
else
    echo -e "${NOTE} Bỏ qua phần cài đặt phần mềm."
fi

# ------------------------------------------------------
# 3. Quản lý cấu hình (Backup & Symlink)
# ------------------------------------------------------
echo -e "\n${ACT} Bắt đầu tiến trình thiết lập cấu hình (Configs)..."
mkdir -p "$BACKUP_DIR"

# Tạo danh sách các thư mục cần cài đặt
for item in "$DOTFILES_DIR/configs/"*; do
    if [ -d "$item" ] || [ -f "$item" ]; then
        target_name=$(basename "$item")
        target_path="$CONFIG_DIR/$target_name"

        # Backup nếu đã tồn tại
        if [ -e "$target_path" ] || [ -L "$target_path" ]; then
            echo -e "${NOTE} Đã tìm thấy cấu hình cũ của ${CY}$target_name${C0}. Đang sao lưu..."
            mv "$target_path" "$BACKUP_DIR/"
        fi
        
        # Symlink
        echo -e "${OK} Đang liên kết: ${CG}$target_name${C0}"
        ln -s "$item" "$target_path"
    fi
done

echo -e "\n${OK} ${CG}${BOLD}CÀI ĐẶT THÀNH CÔNG!${C0}"
echo -e "${NOTE} Cấu hình cũ của bạn đã được sao lưu tại: ${CY}$BACKUP_DIR${C0}"
echo -e "${NOTE} Hãy khởi động lại máy tính (Reboot) để áp dụng toàn bộ thay đổi.\n"
