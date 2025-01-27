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
        diagnostics = {
          darker = false,
          background = false,
        },
      }
      require('onedark').load()
    end,
  }
}
