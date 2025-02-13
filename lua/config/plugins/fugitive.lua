return {
  {
    "tpope/vim-fugitive",
    config = function()
      vim.keymap.set("n", "<leader>gd", ":Gdiffsplit!<CR>", { desc = ":Git diff" })
      vim.keymap.set("n", "<leader>gl", ":0Gclog<CR>", { desc = ":0Gclog" })
      vim.keymap.set("n", "<leader>gL", ":Gclog<CR>", { desc = ":Gclog" })
      vim.keymap.set("n", "<leader>ge", ":Gedit<CR>", { desc = ":Gedit" })
    end,
  }
}
