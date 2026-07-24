# 🚀 My Arch Linux + Hyprland Dotfiles

Chào mừng đến với kho lưu trữ cấu hình (Dotfiles) của mình dành cho hệ điều hành Arch Linux với trình quản lý cửa sổ Hyprland.

## 🖼️ Tổng quan cấu hình

- **OS:** Arch Linux
- **Window Manager:** Hyprland (Wayland)
- **Bar:** Waybar
- **Terminal:** Kitty / Wezterm / Ghostty
- **Launcher:** Rofi / Wofi
- **Shell:** Zsh / Fish + Starship
- **Editor:** Neovim / Vim
- **Keyboard / Input:** Fcitx5
- **Notification:** Swaync

---

## 🛠️ Hướng dẫn cài đặt tự động

Mình đã viết sẵn một script để tự động hóa việc cài đặt các gói phần mềm và thiết lập cấu hình. 

### Bước 1: Clone kho lưu trữ này

Mở terminal và chạy lệnh sau để tải cấu hình về máy:

```bash
git clone git@github.com:TranHoangXuanNguyen/MyDotFile.git ~/dotfiles
cd ~/dotfiles
```

### Bước 2: Chạy Script cài đặt

Khởi chạy script cài đặt tự động:

```bash
chmod +x install.sh
./install.sh
```

**Script này sẽ làm gì?**
1. Hỏi bạn có muốn cài đặt các packages cần thiết (như Hyprland, Waybar, Rofi...) từ `pacman` và `yay` hay không.
2. Tự động tìm các file cấu hình hiện tại trong thư mục `~/.config/` của bạn. Nếu có, nó sẽ **sao lưu (backup)** chúng vào `~/.config/cfg_backups/`.
3. Tạo các **symlink** (đường dẫn ảo) từ thư mục `~/dotfiles/configs/` tới `~/.config/`. Nhờ vậy, mỗi khi bạn cập nhật code trong thư mục `dotfiles`, hệ thống sẽ nhận ngay.

### Bước 3: Khởi động lại
Sau khi chạy xong, hãy đăng xuất hoặc khởi động lại máy để tận hưởng giao diện mới!

---

## 📂 Quản lý thư mục

- Các gói phần mềm tải từ kho chính thức được liệt kê tại `packages-pacman.txt`.
- Các gói phần mềm tải từ AUR (thông qua Yay) được liệt kê tại `packages-aur.txt`.
- Hình nền (Wallpapers) được lưu ở thư mục `configs/wallpapers/`.
- Cấu hình gõ tiếng Việt / Keyboard được lưu ở `configs/fcitx5/` và file `Keybinds.conf`.

---
*Được tạo tự động bằng AI Assistant 🤖*
