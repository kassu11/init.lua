return {
  {
    "navarasu/onedark.nvim",
    config = function()
      require('onedark').setup {
        style = 'cool',
        transparent = true,
        lualine = {
          transparent = true,
        },
      }
      require('onedark').load()
    end,
  }
}
