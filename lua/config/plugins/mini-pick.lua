return {
  "nvim-mini/mini.pick",
  config = function()
    require "mini.pick".setup {}

    vim.keymap.set("n", "<leader>sh", ":Pick help<CR>", { desc = "Search help" })
    vim.keymap.set("n", "<leader>sf", ":Pick files<CR>", { desc = "Search files" })
  end,
}
