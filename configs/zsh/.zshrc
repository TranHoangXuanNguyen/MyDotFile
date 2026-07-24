# --- 1. Tối ưu Lịch sử & Tốc độ ---
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY       # Đồng bộ lịch sử giữa các tab
setopt HIST_IGNORE_DUPS    # Không lưu lệnh trùng lặp

# --- 2. Plugin (Gợi ý & Tô màu) ---
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# --- 3. Alias (Lệnh tắt tiện dụng) ---
alias l="ls -la"
alias c="clear"
alias ..="cd .."

# --- 4. Giao diện Starship (Khởi động siêu nhanh) ---
eval "$(starship init zsh)"
