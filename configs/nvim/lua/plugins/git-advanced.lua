return {
  -- 1. Diffview: Source Control interface similar to VS Code
  {
    "sindrets/diffview.nvim",
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Open DiffView" },
      { "<leader>gx", "<cmd>DiffviewClose<cr>", desc = "Close DiffView" },
      { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "Current File Git History" },
    },
  },
  
  -- 2. Git Conflict: Inline merge conflict resolution similar to VS Code
  {
    "akinsho/git-conflict.nvim",
    version = "*",
    config = function()
      require('git-conflict').setup({
        default_mappings = true, -- Enable default mappings
        disable_diagnostics = true,
        highlights = {
          incoming = 'DiffAdd',
          current = 'DiffText',
        }
      })
    end,
    keys = {
      { "<leader>co", "<cmd>GitConflictChooseOurs<cr>", desc = "Accept Current Change" },
      { "<leader>ct", "<cmd>GitConflictChooseTheirs<cr>", desc = "Accept Incoming Change" },
      { "<leader>cb", "<cmd>GitConflictChooseBoth<cr>", desc = "Accept Both Changes" },
      { "<leader>c0", "<cmd>GitConflictChooseNone<cr>", desc = "Reject Both" },
      { "]x", "<cmd>GitConflictNextConflict<cr>", desc = "Next Conflict" },
      { "[x", "<cmd>GitConflictPrevConflict<cr>", desc = "Prev Conflict" },
    },
  }
}
