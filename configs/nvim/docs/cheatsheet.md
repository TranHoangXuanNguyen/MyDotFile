# ⌨️ Neovim Cheatsheet

> **Leader** = `Space` | **Xem tất cả keymaps**: `<leader>?` hoặc `<leader>fk`

---

## 📁 File & Navigation

| Key | Action |
|-----|--------|
| `<leader>ff` | 🔍 Tìm file (Telescope) |
| `<leader>fo` | 🕐 File gần đây (Recent files) |
| `<leader>fg` | 🔎 Live grep toàn project |
| `<leader>fb` | 📋 Danh sách buffers đang mở |
| `<leader>fh` | ❓ Tìm trong Help |
| `<leader>fk` | ⌨️ Tìm keymaps |
| `<leader>fd` | 🚨 Xem Diagnostics |
| `<leader>fr` | ↩️ Resume picker lần trước |

---

## 🗂️ Buffer

| Key | Action |
|-----|--------|
| `<Tab>` | Buffer tiếp theo |
| `<S-Tab>` | Buffer trước đó |
| `<leader>1`…`<leader>9` | Nhảy thẳng tới buffer 1–9 |
| `\db` | Đóng buffer hiện tại |
| `\dB` | Đóng tất cả buffer khác |
| `gb` | Đi tới buffer (theo số đếm) |
| `gB` | Quay lại buffer (theo số đếm) |

---

## 🪟 Window / Split

| Key | Action |
|-----|--------|
| `<Left>` | Focus cửa sổ bên trái |
| `<Right>` | Focus cửa sổ bên phải |
| `<Up>` | Focus cửa sổ bên trên |
| `<Down>` | Focus cửa sổ bên dưới |
| `:vs` | Chia dọc (vertical split) |
| `:sp` | Chia ngang (horizontal split) |
| `<C-w>=` | Cân bằng kích thước các split |
| `<C-w>o` | Đóng tất cả split khác |

---

## 💻 Terminal

| Key | Action |
|-----|--------|
| `<C-/>` | Bật/tắt terminal (Snacks float) |
| `<C-\`>` | Mở terminal dạng horizontal split |
| `<Esc>` | Thoát khỏi terminal mode |

---

## 🌿 Git

| Key | Action |
|-----|--------|
| `<leader>gg` | 🚀 Mở **Lazygit** |
| `<leader>gl` | 📜 Lazygit Log (cwd) |
| `<leader>gf` | 📄 Lazygit history file hiện tại |
| `<leader>gB` | 🌐 Mở file trên GitHub/GitLab |
| `<leader>gd` | 🔀 Mở Diffview (xem diff đẹp) |
| `<leader>gx` | ✖️ Đóng Diffview |
| `<leader>gh` | 📅 Git history file hiện tại |
| — | — |
| `]h` / `[h` | Nhảy hunk tiếp/trước |
| `<leader>gs` | ✅ Stage hunk |
| `<leader>gu` | ↩️ Unstage hunk |
| `<leader>gU` | 🗑️ Undo thay đổi hunk |
| `<leader>gA` | ✅ Stage toàn bộ file |
| `<leader>gR` | 🗑️ Reset toàn bộ file |
| `<leader>gD` | 👁️ Preview diff hunk |
| `<leader>gB` | 👤 Git blame dòng hiện tại |
| `<leader>gtb` | 🔁 Toggle inline blame |
| `<leader>gtd` | 🔁 Toggle word diff |

---

## 🖱️ Multi-cursor

| Key | Action |
|-----|--------|
| `<C-d>` | Chọn từ tiếp theo giống từ dưới cursor (như VS Code) |
| `<C-S-l>` | Chọn tất cả từ giống nhau trong file |
| `<C-S-j>` | Thêm cursor xuống dưới |
| `<C-S-k>` | Thêm cursor lên trên |
| `<C-LeftMouse>` | Ctrl+Click thêm cursor |
| `<Esc>` | Thoát multi-cursor |

---

## 💾 Save & Quit

| Key | Action |
|-----|--------|
| `<leader>w` | Lưu file |
| `<leader>ws` | Lưu file |
| `<leader>q` | Lưu và đóng cửa sổ |
| `<leader>Q` | Force quit tất cả |
| `<leader>qq` | Quit tất cả |
| `ZR` | Restart Neovim |

---

## 🔍 LSP

| Key | Action |
|-----|--------|
| `gd` | Go to Definition |
| `gr` | Go to References |
| `K` | Hover documentation |
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code actions |
| `<leader>fd` | Xem Diagnostics |
| `]d` / `[d` | Lỗi tiếp/trước |

---

## 🎨 Theme

| Key | Action |
|-----|--------|
| `<leader>ut` | Mở menu Dark themes |
| `<leader>uT` | Mở menu Light themes ☀️ |
| `<leader>utt` | TokyoNight |
| `<leader>utc` | Catppuccin Macchiato |
| `<leader>utr` | Rose Pine |
| `<leader>utk` | Kanagawa |
| `<leader>utp` | Pywal (theo wallpaper) |
| `<leader>uT1` | Tokyo Day ☀️ |
| `<leader>uT2` | Catppuccin Latte ☀️ |
| `<leader>uT3` | Rose Pine Dawn ☀️ |
| `<leader>uT5` | Github Light ☀️ |

---

## 🧰 Tools

| Key | Action |
|-----|--------|
| `<leader>xl` | Mở Lazy (plugin manager) |
| `<leader>xm` | Mở Mason (LSP installer) |
| `<leader>z` | Zen Mode |
| `<leader>s` | Scratch Buffer |
| `<leader>H` | 📖 Mở cheatsheet này |
| `\x` | Đóng quickfix / location list |
| `<F11>` | Bật/tắt spell check |

---

## ✏️ Editing

| Key | Action |
|-----|--------|
| `H` | Đầu dòng |
| `L` | Cuối dòng |
| `<A-j>` / `<A-k>` | Di chuyển dòng/selection lên xuống |
| `<leader>p` / `<leader>P` | Paste dưới/trên dòng hiện tại |
| `<leader>y` | Yank toàn bộ buffer |
| `<leader><space>` | Xóa trailing whitespace |
| `;` | Vào command mode (thay `:`) |
