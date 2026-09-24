return {
    {
        "AlphaTechnolog/pywal.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            -- Guard: pywal file may not exist if `wal` hasn't been run yet
            local wal_file = vim.fn.expand("~/.cache/wal/colors-wal.vim")
            if vim.fn.filereadable(wal_file) == 1 then
                local ok, err = pcall(require("pywal").setup)
                if not ok then
                    vim.notify("pywal.nvim setup failed: " .. tostring(err), vim.log.levels.WARN)
                end
            else
                vim.notify(
                    "pywal: ~/.cache/wal/colors-wal.vim not found. Run `wal -i <wallpaper>` first. Falling back to default theme.",
                    vim.log.levels.WARN
                )
            end
            require("ui_theme").init()
        end,
    },
    {
        "folke/tokyonight.nvim",
        lazy = true,
        opts = {
            style = "storm",
            terminal_colors = true,
            styles = {
                comments = { italic = true },
                keywords = { italic = false },
                sidebars = "dark",
                floats = "dark",
            },
        },
    },
    {
        "ellisonleao/gruvbox.nvim",
        lazy = true,
        opts = {
            contrast = "soft",
            terminal_colors = true,
            italic = {
                strings = false,
                comments = true,
                operators = false,
                folds = false,
            },
            undercurl = true,
        },
    },
    {
        "rebelot/kanagawa.nvim",
        lazy = true,
        opts = {
            theme = "dragon",
            terminalColors = true,
            background = {
                dark = "dragon",
                light = "lotus",
            },
        },
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = true,
        opts = {
            flavour = "macchiato",
            term_colors = true,
            integrations = {
                cmp = true,
                gitsigns = true,
                nvimtree = false,
                treesitter = true,
                telescope = true,
                which_key = true,
            },
        },
    },
    {
        "rose-pine/neovim",
        name = "rose-pine",
        lazy = true,
        opts = {
            variant = "moon",
            dark_variant = "moon",
        },
    },
    {
        "shaunsingh/nord.nvim",
        lazy = true,
        opts = {
            borders = true,
            bold = true,
            italic = true,
        },
    },
    {
        "sainnhe/everforest",
        lazy = true,
        config = function()
            vim.g.everforest_background = "medium"
            vim.g.everforest_enable_italic = 1
            vim.g.everforest_better_performance = 1
        end,
    },
    {
        "navarasu/onedark.nvim",
        lazy = true,
        opts = {
            style = "deep",
        },
    },
    {
        "EdenEast/nightfox.nvim",
        lazy = true,
        opts = {
            options = {
                terminal_colors = true,
                styles = {
                    comments = "italic",
                    keywords = "bold",
                },
            },
        },
    },
    {
        "projekt0n/github-nvim-theme",
        lazy = true,
        config = function()
            require("github-theme").setup({
                options = {
                    terminal_colors = true,
                    darken = {
                        floats = false,
                    },
                },
            })
        end,
    },
    {
        "Mofiqul/vscode.nvim",
        lazy = true,
        opts = {
            transparent = false,
            italic_comments = true,
            disable_nvimtree_bg = true,
        },
    },
    {
        "sainnhe/gruvbox-material",
        lazy = true,
        config = function()
            vim.g.gruvbox_material_background = "medium"
            vim.g.gruvbox_material_foreground = "material"
            vim.g.gruvbox_material_enable_italic = 1
        end,
    },
    {
        "craftzdog/solarized-osaka.nvim",
        lazy = true,
        opts = {
            transparent = false,
            terminal_colors = true,
            styles = {
                comments = { italic = true },
                keywords = { italic = false },
                sidebars = "dark",
                floats = "dark",
            },
        },
    },
    {
        "Mofiqul/dracula.nvim",
        lazy = true,
        opts = {
            italic_comment = true,
            transparent_bg = false,
        },
    },
    {
        "tanvirtin/monokai.nvim",
        lazy = true,
        opts = {},
    },
    {
        "marko-cerovac/material.nvim",
        lazy = true,
        config = function()
            vim.g.material_style = "deep ocean"
            require("material").setup({
                contrast = {
                    terminal = false,
                    sidebars = false,
                    floating_windows = false,
                    non_current_windows = false,
                },
                styles = {
                    comments = { italic = true },
                    keywords = { italic = false },
                },
                plugins = {
                    "gitsigns",
                    "telescope",
                    "which-key",
                },
            })
        end,
    },
    {
        "nyoom-engineering/oxocarbon.nvim",
        lazy = true,
    },
    {
        "kvrohit/mellow.nvim",
        lazy = true,
    },
    {
        "savq/melange-nvim",
        lazy = true,
    },
}

