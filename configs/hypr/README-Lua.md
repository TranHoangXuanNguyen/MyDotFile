# Hyprland Lua và kết quả rà soát

Đã đối chiếu với Hyprland **0.56.2** đang cài trên máy, mẫu `/usr/share/hypr/hyprland.lua`, Lua stubs và mã nguồn đúng tag `v0.56.2`.
[Wiki chính thức](https://wiki.hypr.land/Configuring/Start/) xác nhận Hyprlang bị deprecated từ **0.55**. Bản 0.56.2 này vẫn đọc `.conf`; chưa phải đã bắt buộc bỏ hoàn toàn.

## Dùng bản Lua

Entry point: `~/.config/hypr/hyprland.lua`. Hyprland ưu tiên file này khi khởi động mặc định. Phiên hiện tại đang dùng provider `hyprlang`; cần đăng xuất rồi đăng nhập lại để chuyển provider. Đã chuẩn bị và kiểm tra file, không tự thoát phiên làm việc của bạn.

Nếu trình quản lý phiên có chỉ định `Hyprland -c ...hyprland.conf` hoặc biến `HYPRLAND_CONFIG`, đổi đường dẫn đó thành `...hyprland.lua`. Có thể kiểm tra provider bằng:

```sh
/usr/bin/hyprctl systeminfo
```

Chỉnh các file `UserConfigs/*.lua` sau khi chuyển; các file `.conf` giữ làm bản tương thích và không tự đồng bộ với Lua. Những phần chính:

| File | Nội dung |
| --- | --- |
| `UserConfigs/01-UserDefaults.lua` | Terminal, file manager, editor, công cụ tìm kiếm |
| `configs/SystemSettings.lua` | Input, layout, gestures, cursor |
| `UserConfigs/UserSettings.lua` | Ghi đè cấu hình hệ thống |
| `UserConfigs/UserDecorations.lua` | Border, opacity, blur, shadow |
| `UserConfigs/UserAnimations.lua` | Animation Quick hiện tại |
| `configs/Keybinds.lua`, `UserConfigs/UserKeybinds.lua` | Phím mặc định và phím cá nhân |
| `configs/WindowRules.lua`, `UserConfigs/WindowRules.lua` | Window/layer rules và ghi đè |
| `configs/Startup_Apps.lua`, `UserConfigs/Startup_Apps.lua` | Autostart trong sự kiện `hyprland.start` |
| `monitors.lua`, `workspaces.lua` | Màn hình và workspace, tương thích nwg-displays đang cài |
| `configs/Actions.lua` | Đổi layout, blur, zoom, game mode, màu wallust |

## Những điểm đã sửa

- Quickshell overview được autostart hai lần; nay chỉ một lần. Toggle thử IPC trước khi mở process mới, refresh màu/bar không khởi chạy thêm overview.
- `Super+Tab` / `Super+Shift+Tab` vừa chuyển group vừa chuyển workspace; nay dành cho group. Chuyển workspace bằng số, dấu phẩy/chấm hoặc cuộn chuột như trước.
- Hai tổ hợp Alt/Shift cũ chuyển thành chord trùng khi dịch nguyên sang Lua. Dùng `Alt+Shift trái` để đổi layout bàn phím toàn cục, `Super+Alt+Shift trái` cho từng cửa sổ. Chỉ có tác dụng đổi ngôn ngữ khi đã cấu hình nhiều `input.kb_layout`.
- `Super+J/K` được khai báo trong Lua ở mỗi lần reload, luôn cycle cửa sổ. Không còn phụ thuộc thứ tự chạy hai script init. `Super+O` toggle split ở dwindle, swap master ở master.
- `Alt+Tab` gộp cycle và bring-to-top thành một callback. Bỏ keysym không tồn tại `XF86AudioPlayPause`; vẫn giữ `XF86AudioPlay` và `XF86AudioPause`.
- Bỏ idle-inhibit fullscreen lặp và regex `^*$`; sửa regex Steam app IDs và JetBrains. Rule game được gộp, dùng `fullscreen = true` rõ ràng thay cho `fullscreen 0` đang sai nghĩa ở rule v3.
- Bỏ việc gán `QT_QPA_PLATFORMTHEME` hai lần; giữ `qt6ct` vốn là giá trị có hiệu lực trước đó.
- Hai màn hình được runtime báo không hỗ trợ VRR: bản Lua đặt VRR mặc định 0. Giữ nguyên độ phân giải, vị trí, scale bạn vừa chọn trong nwg-displays.
- Giữ blur **1 pass**, gap nhỏ và góc vuông bạn đã chỉnh; không tăng lại lên 3 pass trên Intel HD 520.
- Bỏ override touchpad ASUS không khớp máy Dell hiện tại. Script tự tìm touchpad; có thể chỉ định `TOUCHPAD_DEVICE` khi cần. Bỏ autostart app ROG không dùng trên máy này.
- Game mode Lua tắt animations/blur/shadow, giảm gaps và ép opacity; tắt game mode khôi phục chính xác giá trị trước đó, kể cả khi animations đã tắt sẵn. Không kill wallpaper hay restart bar.
- Zoom Lua giới hạn trong khoảng 1–16, tránh zoom-out xuống dưới mức bình thường.
- Các menu mở đúng file Lua, tìm phím tắt từ `hyprctl binds`, và tìm kiếm web thay đúng placeholder `{}`. Không còn `source`/`eval` cả config Hyprland như shell script.

Các chỉnh sửa về startup, bind trùng, regex/rules, Qt theme và touchpad cũng được áp dụng vào bản `.conf` hiện tại khi phù hợp.

## Script và dữ liệu sinh tự động

Lua không còn hỗ trợ cú pháp IPC cũ cho `hyprctl keyword` và `hyprctl dispatch`. Phiên Lua thêm `hypr/bin` vào PATH: wrapper chuyển những lệnh cũ đang được desktop scripts sử dụng sang API Lua. Query đi thẳng tới `/usr/bin/hyprctl` để tránh chi phí Python. Config Lua chính dùng API native; không nạp config `.conf` qua bộ chuyển đổi.

Wrapper không phải bộ chuyển đổi mọi cú pháp Hyprlang. Script cũ không được config này gọi, ví dụ `scripts/Tak0-Autodispatch.sh` dùng `windowrulev2`, cần viết lại trước khi tự kích hoạt. Wrapper báo lỗi rõ ràng cho các thao tác chưa hỗ trợ. Có thể gọi `/usr/bin/hyprctl` trực tiếp để dùng CLI gốc.

Wallust tiếp tục sinh `wallust/wallust-hyprland.conf`; Lua chỉ đọc các giá trị màu `rgb/rgba` trong file như dữ liệu. `WallustSwww.sh` áp lại màu qua `hypr_dots.apply_colors()` sau khi đổi wallpaper. Không cần sửa cấu hình Wallust bên ngoài repo. Wallpaper ảnh/video lưu trạng thái trong `UserConfigs/Wallpaper.lua`; lựa chọn hiện tại mặc định là ảnh.

`hypridle.conf`, `hyprlock.conf`, các config Kitty/Rofi/Waybar vẫn dùng định dạng riêng của từng ứng dụng, không đổi sang Lua theo Hyprland. Lệnh DPMS của hypridle và lệnh đóng phiên của wlogout được wrapper chuyển đổi khi chạy trong phiên Lua.

## Kiểm tra

Chạy từ thư mục `configs`:

```sh
Hyprland --verify-config -c "$PWD/hypr/hyprland.lua"
Hyprland --verify-config -c "$PWD/hypr/hyprland.conf"
PYTHONDONTWRITEBYTECODE=1 python3 hypr/tests/check-lua.py
```

Bộ kiểm tra dùng parser/API thực của Hyprland qua `--verify-config`: nạp toàn bộ config, kiểm tra callback đổi layout/blur/zoom, bật/tắt game mode hai lần với giá trị tùy chỉnh, và dựng các dispatcher IPC tương thích. Có kiểm tra bind trùng, target cửa sổ, tọa độ tương đối/tuyệt đối và bảo toàn chuỗi shell. Không chạy autostart và không điều khiển cửa sổ của phiên hiện tại.

Các kiểm tra này chưa chứng minh toàn bộ giao diện và mọi phím phần cứng hoạt động sau đăng nhập. Chưa đo FPS hay điện năng; thay đổi hiệu năng dựa trên việc loại process/cấu hình thừa và giữ blur nhẹ.

## Quay lại `.conf`

Nếu cần quay lại với Hyprland 0.56.2, từ TTY hoặc trình quản lý phiên khởi động rõ đường dẫn:

```sh
Hyprland -c "$HOME/.config/hypr/hyprland.conf"
```

Hoặc đổi tên `hyprland.lua` thành `hyprland.lua.disabled` trước lần đăng nhập kế tiếp để dùng cơ chế chọn config mặc định. Giữ cả thư mục Lua và scripts khi sử dụng bản Lua; chỉ copy riêng entry point sẽ thiếu các module cần thiết.

Chi tiết tinh chỉnh animation, startup và bản lưu các file đã dọn: [README-Performance.md](README-Performance.md).
