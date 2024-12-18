return {
  {
    "stevearc/dressing.nvim",
    config = function()
      vim.api.nvim_set_hl(0, "MyNormal", { bg = "None", fg = "White" })
      vim.api.nvim_set_hl(0, "MyNormalNC", { bg = "None", fg = "None" })
      vim.api.nvim_set_hl(0, "MyNonText", { bg = "None", fg = "None" })
      vim.api.nvim_set_hl(0, "MyNormalFloat", { bg = "None", fg = "None" })
      vim.api.nvim_set_hl(0, "MyFloatBorder", { bg = "None", fg = "#464140" })
      vim.api.nvim_set_hl(0, "MyCursorLine", { bg = "#837674", fg = "White" })

      require("dressing").setup({
        input = {
          win_options = {
            winblend = 0,
            winhighlight =
            "Normal:MyNormal,FloatBorder:MyFloatBorder,CursorLine:MyCursorLine,NormalFloat:MyNormalFloat,NormalNC:MyNormalNC,NonText:MyNonText,Search:None",
          },
        },
      })
    end,
  }
}
