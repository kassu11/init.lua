return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    require "nvim-treesitter".setup {
      install_dir = vim.fn.stdpath("data") .. "/site"
    }

    require "nvim-treesitter".install { "rust", "zig", "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "jsdoc", "html", "css", "javascript", "typescript", "tsx" }
  end,
}
