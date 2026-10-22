# Tinh chỉnh cho Intel HD 520 / 60 Hz

Preset **Quick** dùng animation cửa sổ 120–180 ms, workspace 200 ms với quãng trượt ngắn, tắt animation viền. Cấu hình đã áp dụng cho cả `.conf` và Lua; giữ preset cũ tại `animations/End-4.{conf,lua}` để chọn lại bằng menu animation. File đang dùng là `UserConfigs/UserAnimations.{conf,lua}`.

- Blur giảm size từ 6 xuống 4, giữ 1 pass; tắt blur popup và special workspace. Giữ opacity, gaps và shadow hiện có.
- Dropdown terminal chỉ mở khi bấm phím tắt. Bỏ vòng lặp di chuyển từng frame trong shell; Hyprland xử lý chuyển động. Địa chỉ cửa sổ được lưu riêng theo phiên trong `$XDG_RUNTIME_DIR`.
- Bỏ autostart ulauncher và ứng dụng ASUS ROG không dùng. Quickshell overview chỉ khởi chạy một lần.
- Waybar thực tế dùng `configs/[TOP] Simple`: CPU cập nhật mỗi 5 giây, RAM mỗi 15 giây; drawer 160 ms. Bỏ nút cập nhật dotfiles khỏi nhóm thông báo. Giữ thông báo swaync.
- Tắt cursor trail trong Kitty; có hiệu lực với cửa sổ mới.
- Launcher của Waybar đọc defaults chung an toàn khi chạy với Lua.

## File đã dọn

43 file, tổng **44.145.798 byte (~42,1 MiB)**, đã chuyển sang:

```
/home/ikiguyz/.local/state/dotfiles-cleanup/20261022-222927
```

Bao gồm backup cũ, 33 ảnh mẫu Fastfetch không được preset nào tham chiếu và hai file IPC IBus theo phiên. Giữ ảnh `everyday.png`, thư mục ảnh Fastfetch đang dùng và các theme/preset có thể chọn. `.gitignore` mới loại backup, cache Python và dữ liệu IPC khỏi các lần thêm file sau.

`manifest.json` trong bản lưu ghi đường dẫn tương đối với `/home/ikiguyz/dotfiles/configs`, dung lượng, SHA256 và lý do dọn. Muốn khôi phục, copy riêng file cần dùng từ bản lưu về đường dẫn cũ; kiểm tra trước nếu đích đã tồn tại để tránh ghi đè thay đổi mới.

## Kiểm tra và áp dụng

Hai entry point Hyprland đều đã qua `--verify-config`; bộ kiểm tra Lua/API, cú pháp shell và cấu hình Waybar cũng được kiểm tra. Animation và blur được đọc lại từ compositor sau reload. Chưa đo FPS hoặc mức tiêu thụ điện.

Phiên hiện tại vẫn chạy `.conf`; bản Lua dùng ở lần đăng nhập tiếp theo. Các tinh chỉnh hiệu ứng đã có trong cả hai định dạng nên không cần đăng xuất để nhận animation mới.
