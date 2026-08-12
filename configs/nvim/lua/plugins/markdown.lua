return {
    {
        -- Render markdown inline inside Neovim (existing plugin - kept)
        "OXY2DEV/markview.nvim",
        lazy = false,
        opts = function()
            local state = require("settings_state")
            return {
                preview = {
                    enable = state.get("markview_preview", true),
                    enable_hybrid_mode = state.get("markview_hybrid", true),
                    modes = { "n", "no", "c", "i" },
                    hybrid_modes = { "i" },
                    linewise_hybrid_mode = true,
                    icon_provider = "internal",
                    debounce = 80,
                    max_buf_lines = 5000,
                },
                experimental = {
                    fancy_comments = true,
                },
            }
        end,
        config = function(_, opts)
            require("markview").setup(opts)

            -- Global keymap: works regardless of when the file was opened
            vim.keymap.set("n", "<leader>ms", function()
                if vim.bo.filetype ~= "markdown" then
                    vim.notify("Not a markdown file", vim.log.levels.WARN)
                    return
                end

                local cur_buf = vim.api.nvim_get_current_buf()
                local key = "md_preview_win_" .. cur_buf
                local preview_win = vim.g[key]

                -- Toggle off if already open
                if preview_win and vim.api.nvim_win_is_valid(preview_win) then
                    vim.api.nvim_win_close(preview_win, true)
                    vim.g[key] = nil
                    return
                end

                local src_win = vim.api.nvim_get_current_win()

                -- Open vertical split on the right with the same buffer
                vim.cmd("vsplit")
                local preview_win_new = vim.api.nvim_get_current_win()
                vim.api.nvim_win_set_buf(preview_win_new, cur_buf)

                -- Clean look for preview pane
                local wo = vim.wo[preview_win_new]
                wo.number         = false
                wo.relativenumber = false
                wo.signcolumn     = "no"
                wo.foldcolumn     = "0"
                wo.cursorline     = false
                wo.wrap           = true
                wo.linebreak      = true

                vim.g[key] = preview_win_new

                -- Sync scroll: editor -> preview
                vim.api.nvim_create_autocmd({ "CursorMoved", "WinScrolled" }, {
                    buffer = cur_buf,
                    group = vim.api.nvim_create_augroup("MdSplitSync_" .. cur_buf, { clear = true }),
                    callback = function()
                        if not vim.api.nvim_win_is_valid(preview_win_new) then return end
                        if vim.api.nvim_get_current_win() ~= src_win then return end
                        local view = vim.api.nvim_win_call(src_win, vim.fn.winsaveview)
                        vim.api.nvim_win_call(preview_win_new, function()
                            vim.fn.winrestview(view)
                        end)
                    end,
                })

                -- Cleanup when preview window is closed
                vim.api.nvim_create_autocmd("WinClosed", {
                    pattern = tostring(preview_win_new),
                    once = true,
                    callback = function()
                        vim.g[key] = nil
                        pcall(vim.api.nvim_del_augroup_by_name, "MdSplitSync_" .. cur_buf)
                    end,
                })

                -- Return focus to edit pane
                vim.api.nvim_set_current_win(src_win)
            end, { desc = "Toggle Markdown Split Preview (side-by-side)" })
        end,
    },


    {
        -- Browser-based Markdown preview with Mermaid chart support
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = "cd app && npm install",
        keys = {
            { "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", ft = "markdown", desc = "Toggle Markdown Preview in Browser" },
        },
        config = function()
            -- Use system default browser
            vim.g.mkdp_browser = ""
            -- Auto-close preview when leaving markdown buffer
            vim.g.mkdp_auto_close = 1
            -- Preview server port (0 = random available port)
            vim.g.mkdp_port = ""
            -- Open preview in a new browser tab
            vim.g.mkdp_open_to_the_world = 0
            -- Custom page title: [filename].md
            vim.g.mkdp_page_title = "${name}.md"
            -- Enable Mermaid.js chart rendering
            vim.g.mkdp_preview_options = {
                mkit = {},
                katex = {},
                uml = {},
                maid = {}, -- Mermaid support
                disable_sync_scroll = 0,
                sync_scroll_type = "middle",
                hide_yaml_meta = 1,
                sequence_diagrams = {},
                flowchart_diagrams = {},
                content_editable = false,
                disable_filename = 0,
                toc = {},
            }
            -- Use a theme that supports Mermaid (markdown-preview has built-in mermaid support)
            vim.g.mkdp_markdown_css = ""
            vim.g.mkdp_highlight_css = ""
        end,
    }
}
