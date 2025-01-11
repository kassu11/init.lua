return {
  {
    "andymass/vim-matchup",
    enabled = true,
    dependencies = { "nvim-telescope/telescope.nvim", },
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }

      -- If set to 1, middle words (like `return`) are not matched to start and
      -- end words for higlighting and motions.
      vim.g.matchup_delim_nomids = 1
      vim.keymap.del("i", "<C-g>%");
    end,
  },
}
