return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local install = require("nvim-treesitter.install");
      install.prefer_git = false
      install.compilers = { "zig", vim.fn.getenv('CC'), "cc", "gcc", "clang", "cl" }

      ---@diagnostic disable-next-line: missing-fields
      require 'nvim-treesitter.configs'.setup {
        matchup = {
          enable = true, -- Enable Treesitter-based % functionality
        },
        ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "zig", "jsdoc", "html" },
        auto_install = false,
        indent = {
          enable = true,
          disable = function(lang, buf)
            return lang == "jsdoc"
          end,
        },
        highlight = {
          enable = true,
          disable = function(lang, buf)
            local max_filesize = 101 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end,
          additional_vim_regex_highlighting = false,
        },
      }
    end,
  }
}
