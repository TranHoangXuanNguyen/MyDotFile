return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      size = 20,
      open_mapping = [[<c-\>]], -- Ctrl + \ (phím xuyệt chéo)
      hide_numbers = true,
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      terminal_mappings = true,
      persist_size = true,
      direction = "float", -- Hiển thị lơ lửng ở giữa màn hình
      close_on_exit = true,
      shell = vim.o.shell,
      float_opts = {
        border = "curved",
        winblend = 0,
        highlights = {
          border = "Normal",
          background = "Normal",
        },
      },
    })

    -- Phím tắt hỗ trợ thao tác nhanh cho nhiều terminal
    local keymap = vim.keymap.set

    -- Mở theo số thứ tự từ 1 đến 9 (ấn Leader (Space) + t + số)
    for i = 1, 9 do
      keymap("n", "<leader>t" .. i, "<cmd>" .. i .. "ToggleTerm<cr>", { desc = "Terminal " .. i })
    end

    -- Mở theo chiều ngang / dọc nếu không thích dùng lơ lửng
    keymap("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical size=60<cr>", { desc = "Vertical Terminal" })
    keymap("n", "<leader>th", "<cmd>ToggleTerm direction=horizontal size=15<cr>", { desc = "Horizontal Terminal" })
  end,
}
