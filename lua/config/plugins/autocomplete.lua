local show_popup = true

vim.keymap.set("n", "<leader>å", function() show_popup = not show_popup end, { desc = "Disable auto autocomplete pupup" })

return {
  {
    "saghen/blink.cmp",
    dependencies = "rafamadriz/friendly-snippets",
    version = "*",
    opts = {
      keymap = {
        preset = "default",
        ["<C-k>"] = { function() require("blink.cmp.signature.trigger").show() end, },
        -- cmd remap
        ["<M-å><space>"] = { "show", "show_documentation", "hide_documentation" },
      },

      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono"
      },
      completion = {
        menu = {
          -- Hide autocomplete on file
          auto_show = function(ctx) return ctx.mode ~= "default" or show_popup end
        }
      },

      signature = { enabled = true }
    },
  },
}
