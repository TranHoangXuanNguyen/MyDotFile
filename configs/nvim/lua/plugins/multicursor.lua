return {
    "mg979/vim-visual-multi",
    branch = "master",
    event = "BufReadPost",
    init = function()
        -- Ctrl+D giống VS Code (chọn từ tiếp theo giống nhau)
        vim.g.VM_maps = {
            ["Find Under"]         = "<C-d>",   -- Ctrl+D: chọn từ kế tiếp (giống VS Code)
            ["Find Subword Under"] = "<C-d>",
            ["Select All"]         = "<C-S-l>", -- Ctrl+Shift+L: chọn tất cả
            ["Add Cursor Up"]      = "<C-S-k>", -- Ctrl+Shift+K: thêm cursor lên
            ["Add Cursor Down"]    = "<C-S-j>", -- Ctrl+Shift+J: thêm cursor xuống
            ["Add Cursor At Pos"]  = "<C-LeftMouse>", -- Ctrl+Click: thêm cursor
        }
        -- Hiện số lượng cursor đang active
        vim.g.VM_show_warnings = 1
        vim.g.VM_silent_exit = 0
        -- Theme cho cursors
        vim.g.VM_theme = "iceblue"
    end,
}
