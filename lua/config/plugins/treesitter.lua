return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    require "nvim-treesitter".setup {
      install_dir = vim.fn.stdpath("data") .. "/site"
    }

    require "nvim-treesitter".install { "rust", "zig", "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "jsdoc", "html", "css", "javascript", "typescript", "tsx" }

    vim.api.nvim_create_autocmd("FileType", {
      callback = function()
        -- Enable treesitter highlighting and disable regex syntax
        pcall(vim.treesitter.start)
        -- Enable treesitter-based indentation
        -- vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

        vim.opt.smartindent = false   -- Disable smartindent
        vim.opt.cindent = false       -- Disable C-style indenting
        vim.opt.indentexpr = ""       -- Disable filetype-specific indent scripts
        vim.opt.autoindent = true     -- Enable basic auto-indent (copy previous line)
      end,
    })
  end,
}
