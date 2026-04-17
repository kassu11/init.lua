return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local colors = {
        active = "#1c1c24",
        white = "#c6c6c6",
      }

      local bubbles_theme = {
        normal = {
          a = { bg = colors.active },
          y = { fg = colors.white, bg = colors.active },
        },
        insert = {},
        visual = {},
        replace = {},
        inactive = {
          a = { bg = colors.active },
          z = { bg = colors.active },
        },
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
        inactive_sections = {
          lualine_a = { 'filename' },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = { 'location' },
        },
        tabline = {},
        extensions = {},
      }
    end,
  }
}
