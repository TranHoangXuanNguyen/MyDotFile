# ⌨️ Neovim Cheatsheet

> **Leader** = `Space` | **Show all keymaps**: `<leader>?` or `<leader>fk`

---

## 📁 File & Navigation

| Key | Action |
|-----|--------|
| `<leader>ff` | 🔍 Find file |
| `<leader>fo` | 🕐 Recent files |
| `<leader>fg` | 🔎 Live grep (search across project) |
| `<leader>fb` | 📋 List open buffers |
| `<leader>fh` | ❓ Search help docs |
| `<leader>fk` | ⌨️ Find keymaps |
| `<leader>fd` | 🚨 View diagnostics (errors/warnings) |
| `<leader>fr` | ↩️ Resume last search |

---

## 🗂️ Buffer

| Key | Action |
|-----|--------|
| `<Tab>` | Next buffer |
| `<S-Tab>` | Previous buffer |
| `<leader>1` … `<leader>9` | Jump to buffer 1–9 |
| `\db` | Close current buffer |
| `\dB` | Close all other buffers |
| `gb` | Go to buffer (forward by count) |
| `gB` | Go to buffer (backward by count) |

---

## 🪟 Window / Split

| Key | Action |
|-----|--------|
| `<Left>` | Focus left window |
| `<Right>` | Focus right window |
| `<Up>` | Focus upper window |
| `<Down>` | Focus lower window |
| `:vs` | Vertical split |
| `:sp` | Horizontal split |
| `<C-w>=` | Equalize window sizes |
| `<C-w>o` | Close all other windows |

---

## 💻 Terminal

| Key | Action |
|-----|--------|
| `<C-/>` | Toggle terminal (floating) |
| `` <C-`> `` | Open terminal (horizontal split) |
| `<Esc>` | Exit terminal mode |

---

## 🌿 Git

| Key | Action |
|-----|--------|
| `<leader>gg` | 🚀 Open **Lazygit** |
| `<leader>gl` | 📜 Lazygit log (cwd) |
| `<leader>gf` | 📄 Lazygit history for current file |
| `<leader>gB` | 🌐 Open file on GitHub / GitLab |
| `<leader>gd` | 🔀 Open Diffview |
| `<leader>gx` | ✖️ Close Diffview |
| `<leader>gh` | 📅 Git history for current file |
| — | — |
| `]h` / `[h` | Jump to next / prev hunk |
| `<leader>gs` | ✅ Stage hunk |
| `<leader>gu` | ↩️ Unstage hunk |
| `<leader>gU` | 🗑️ Undo hunk changes |
| `<leader>gA` | ✅ Stage entire file |
| `<leader>gR` | 🗑️ Reset entire file to HEAD |
| `<leader>gD` | 👁️ Preview hunk diff |
| `<leader>gtb` | 🔁 Toggle inline git blame |
| `<leader>gtd` | 🔁 Toggle word diff |

---

## 🖱️ Multi-cursor

| Key | Action |
|-----|--------|
| `<C-d>` | Select next occurrence (like VS Code `Ctrl+D`) |
| `<C-S-l>` | Select all occurrences in file |
| `<C-S-j>` | Add cursor below |
| `<C-S-k>` | Add cursor above |
| `<C-LeftMouse>` | Ctrl+Click to add cursor |
| `<Esc>` | Exit multi-cursor mode |

---

## 💾 Save & Quit

| Key | Action |
|-----|--------|
| `<leader>w` | Save file |
| `<leader>q` | Save and close window |
| `<leader>Q` | Force quit all |
| `<leader>qq` | Quit all |
| `ZR` | Restart Neovim |

---

## 🔍 LSP

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gr` | Go to references |
| `K` | Hover documentation |
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code actions |
| `<leader>fd` | View all diagnostics |
| `]d` / `[d` | Next / prev diagnostic |

---

## 🎨 Theme

| Key | Action |
|-----|--------|
| `<leader>ut` | Dark theme menu 🌙 |
| `<leader>uT` | Light theme menu ☀️ |
| `<leader>utt` | TokyoNight |
| `<leader>utc` | Catppuccin Macchiato |
| `<leader>utr` | Rose Pine |
| `<leader>utk` | Kanagawa |
| `<leader>utp` | Pywal (follows wallpaper) |
| `<leader>uT1` | Tokyo Day ☀️ |
| `<leader>uT2` | Catppuccin Latte ☀️ |
| `<leader>uT3` | Rose Pine Dawn ☀️ |
| `<leader>uT5` | Github Light ☀️ |

---

## 🧰 Tools

| Key | Action |
|-----|--------|
| `<leader>xl` | Open Lazy (plugin manager) |
| `<leader>xm` | Open Mason (LSP installer) |
| `<leader>z` | Toggle Zen Mode |
| `<leader>s` | Scratch buffer |
| `<leader>H` | 📖 Open this cheatsheet |
| `\x` | Close quickfix / location list |
| `<F11>` | Toggle spell check |

---

## ✏️ Editing

| Key | Action |
|-----|--------|
| `H` | Jump to start of line |
| `L` | Jump to end of line |
| `<A-j>` / `<A-k>` | Move line / selection down / up |
| `<leader>p` / `<leader>P` | Paste below / above current line |
| `<leader>y` | Yank entire buffer |
| `<leader><space>` | Remove trailing whitespace |
| `;` | Enter command mode (replaces `:`) |
