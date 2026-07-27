return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		require("neo-tree").setup({
			window = {
				mappings = {
					["<Left>"] = function() vim.cmd("wincmd h") end,
					["<Right>"] = function() vim.cmd("wincmd l") end,
					["<Up>"] = function() vim.cmd("wincmd k") end,
					["<Down>"] = function() vim.cmd("wincmd j") end,
				}
			}
		})
		vim.keymap.set("n", "<C-n>", ":Neotree filesystem reveal left<CR>")
		vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>")
	end,
}
