return {
  {
    enabled = false,
    "HiPhish/rainbow-delimiters.nvim",
    config = function()
      require 'rainbow-delimiters.setup'.setup {
        highlight = {
          'RainbowDelimiterYellow',
          'RainbowDelimiterViolet',
          'RainbowDelimiterBlue',
        },
      }

      vim.cmd [[hi RainbowDelimiterYellow guifg=#ffd700 ctermfg=White]]
      vim.cmd [[hi RainbowDelimiterViolet guifg=#da70d6 ctermfg=White]]
      vim.cmd [[hi RainbowDelimiterBlue guifg=#179fff ctermfg=White]]
    end,
  }
}
