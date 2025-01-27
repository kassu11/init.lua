return {
  {
    "tpope/vim-fugitive",
    config = function()
      vim.keymap.set("n", "<leader>gd", ":Gdiffsplit!<CR>", { desc = ":Git diff" })
    end,
  }
}
