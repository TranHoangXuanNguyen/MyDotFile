return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        bigfile = { enabled = true },
        indent = { enabled = true },
        input = { enabled = true },
        quickfile = { enabled = true },
        scroll = { enabled = true },
        statuscolumn = { enabled = true },
        words = { enabled = true },
    },
    keys = {
        { "<leader>z",  function() Snacks.zen() end, desc = "Toggle Zen Mode" },
        { "<leader>s",  function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
        { "<leader>S",  function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
        { "<c-/>",      function() Snacks.terminal() end, desc = "Toggle Terminal", mode = { "n", "t" } },
        { "<c-_>",      function() Snacks.terminal() end, desc = "which_key_ignore", mode = { "n", "t" } },
        { "<leader>gB", function() Snacks.gitbrowse() end, desc = "Git Browse (open in browser)", mode = { "n", "v" } },
        { "<leader>gf", function() Snacks.lazygit.log_file() end, desc = "Lazygit: Current File History" },
        { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit: Open" },
        { "<leader>gl", function() Snacks.lazygit.log() end, desc = "Lazygit: Log (cwd)" },
        {
            "<leader>H",
            function()
                Snacks.win({
                    file = vim.fn.stdpath("config") .. "/docs/cheatsheet.md",
                    width = 0.8,
                    height = 0.85,
                    wo = {
                        spell = false,
                        wrap = false,
                        signcolumn = "no",
                        statuscolumn = " ",
                        conceallevel = 3,
                        filetype = "markdown",
                    },
                    bo = { filetype = "markdown" },
                })
            end,
            desc = "📖 Cheatsheet",
        },
        {
            "<leader>N",
            desc = "Neovim News",
            function()
                Snacks.win({
                    file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
                    width = 0.6,
                    height = 0.8,
                    wo = {
                        spell = false,
                        wrap = false,
                        signcolumn = "yes",
                        statuscolumn = " ",
                        conceallevel = 3,
                    },
                })
            end,
        }
    },
    init = function()
        vim.api.nvim_create_autocmd("User", {
            pattern = "VeryLazy",
            callback = function()
                _G.dd = function(...)
                    Snacks.debug.inspect(...)
                end
                _G.bt = function()
                    Snacks.debug.backtrace()
                end
                vim.print = _G.dd 
                -- Create some toggle mappings
                Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
                Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
            end,
        })
    end,
}
