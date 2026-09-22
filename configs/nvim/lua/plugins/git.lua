return {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local gs = require("gitsigns")
        gs.setup({
            signs = {
                add          = { text = "┃" },
                change       = { text = "┃" },
                delete       = { text = "_" },
                topdelete    = { text = "‾" },
                changedelete = { text = "~" },
                untracked    = { text = "┆" },
            },
            signs_staged = {
                add          = { text = "┃" },
                change       = { text = "┃" },
                delete       = { text = "_" },
                topdelete    = { text = "‾" },
                changedelete = { text = "~" },
                untracked    = { text = "┆" },
            },
            signs_staged_enable = true,
            signcolumn = true,
            numhl      = false,
            linehl     = false,
            word_diff  = false,
            watch_gitdir = { follow_files = true },
            auto_attach = true,
            attach_to_untracked = false,
            current_line_blame = false,
            current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = "eol",
                delay = 1000,
                ignore_whitespace = false,
                virt_text_priority = 100,
                use_focus = true,
            },
            current_line_blame_formatter = "<author>, <author_time:%R> - <summary>",
            sign_priority = 6,
            update_debounce = 100,
            status_formatter = nil,
            max_file_length = 40000,
            preview_config = {
                border = "rounded",
                style = "minimal",
                relative = "cursor",
                row = 0,
                col = 1,
            },
            on_attach = function(bufnr)
                local map = function(mode, l, r, desc)
                    vim.keymap.set(mode, l, r, { buffer = bufnr, silent = true, desc = desc })
                end

                -- Di chuyển giữa các hunk (thay đổi)
                map("n", "]h", function()
                    if vim.wo.diff then vim.cmd.normal({ "]c", bang = true })
                    else gs.next_hunk() end
                end, "Git: Next hunk")
                map("n", "[h", function()
                    if vim.wo.diff then vim.cmd.normal({ "[c", bang = true })
                    else gs.prev_hunk() end
                end, "Git: Prev hunk")

                -- Stage / unstage / undo hunk (giống VS Code)
                map({ "n", "v" }, "<leader>gs", gs.stage_hunk,   "Git: Stage hunk")
                map({ "n", "v" }, "<leader>gu", gs.undo_stage_hunk, "Git: Unstage hunk")
                map("n", "<leader>gU", gs.reset_hunk,            "Git: Undo hunk changes")
                map("n", "<leader>gA", gs.stage_buffer,          "Git: Stage entire file")
                map("n", "<leader>gR", gs.reset_buffer,          "Git: Reset entire file")

                -- Preview diff inline
                map("n", "<leader>gD", gs.preview_hunk,          "Git: Preview hunk diff")
                map("n", "<leader>gI", gs.preview_hunk_inline,   "Git: Preview hunk inline")

                -- Blame
                map("n", "<leader>gB", function() gs.blame_line({ full = true }) end, "Git: Blame line (full)")
                map("n", "<leader>gtb", gs.toggle_current_line_blame, "Git: Toggle inline blame")

                -- Toggle word diff
                map("n", "<leader>gtd", gs.toggle_word_diff,     "Git: Toggle word diff")
                map("n", "<leader>gtD", gs.diffthis,             "Git: Diff this file")

                -- Text objects: chọn nội dung trong hunk
                map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "Git: Select hunk")
            end,
        })
    end,
}


