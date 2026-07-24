#!/bin/bash

# ==============================================================================
# Dotfiles Installation Script
# ==============================================================================

# Thiết lập thư mục
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$HOME/.config"
BACKUP_DIR="$HOME/.config/cfg_backups/backup_$(date +%Y%m%d_%H%M%S)"

# Màu sắc cho log
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${BLUE}Bắt đầu cài đặt Dotfiles...${NC}\n"

# 1. Cài đặt các gói phần mềm (Packages)
read -p "Bạn có muốn cài đặt các packages cần thiết (Hyprland, Waybar, v.v.) không? (y/n): " INSTALL_PKG
if [[ "$INSTALL_PKG" == "y" || "$INSTALL_PKG" == "Y" ]]; then
    echo -e "${YELLOW}Đang cài đặt packages từ kho chính thức (Pacman)...${NC}"
    sudo pacman -Syu --needed - < "$DOTFILES_DIR/packages-pacman.txt"
    
    # Kiểm tra xem yay có được cài đặt không
    if command -v yay &> /dev/null; then
        echo -e "${YELLOW}Đang cài đặt packages từ AUR (Yay)...${NC}"
        yay -S --needed - < "$DOTFILES_DIR/packages-aur.txt"
    else
        echo -e "${YELLOW}Cảnh báo: Không tìm thấy 'yay'. Bỏ qua cài đặt từ AUR.${NC}"
    fi
fi

# 2. Tạo backup và liên kết (Symlink) cấu hình
echo -e "\n${BLUE}Đang tạo Backup và Symlink các cấu hình...${NC}"
mkdir -p "$BACKUP_DIR"

for item in "$DOTFILES_DIR/configs/"*; do
    if [ -d "$item" ] || [ -f "$item" ]; then
        target_name=$(basename "$item")
        target_path="$CONFIG_DIR/$target_name"

        # Nếu file/folder đã tồn tại, backup nó
        if [ -e "$target_path" ] || [ -L "$target_path" ]; then
            echo -e "Đang sao lưu: ${YELLOW}$target_name${NC} -> $BACKUP_DIR"
            mv "$target_path" "$BACKUP_DIR/"
        fi
        
        # Tạo symlink
        echo -e "Tạo liên kết (symlink): ${GREEN}$target_name${NC}"
        ln -s "$item" "$target_path"
    fi
done

echo -e "\n${GREEN}Cài đặt hoàn tất! Đừng quên khởi động lại Hyprland hoặc máy tính của bạn.${NC}"
