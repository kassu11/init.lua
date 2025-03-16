return {
  {
    "olrtg/nvim-emmet",
    config = function()
      vim.keymap.set({ "n", "v" }, "<leader>ce", require("nvim-emmet").wrap_with_abbreviation)
      vim.keymap.set("i", "<C-e>", require("nvim-emmet").wrap_with_abbreviation)
    end,
  },
}
