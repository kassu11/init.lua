return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local colors = {
        white = "#c6c6c6",
      }

      local bubbles_theme = {
        normal = {
          z = { fg = colors.white },
          y = { fg = colors.white },
        },
        insert = {},
        visual = {},
        replace = {},
      }

      require("lualine").setup {
        options = {
          theme = bubbles_theme,
          component_separators = "",
          section_separators = "",
        },
        sections = {
          lualine_a = { { "filename", path = 1 }, "branch", "diff", "diagnostics" },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = { "filetype", "progress", "location" },
        },
        tabline = {},
        extensions = {},
      }
    end,
  }
}
