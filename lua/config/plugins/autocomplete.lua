return {
  {
    'saghen/blink.cmp',
    dependencies = 'rafamadriz/friendly-snippets',
    version = '*',
    opts = {
      keymap = {
        preset = 'default',
        ["<C-k>"] = { function() require("blink.cmp.signature.trigger").show() end, },
      },

      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono'
      },
      completion = {
        menu = {
          -- Hide autocomplete on file
          auto_show = function(ctx) return ctx.mode ~= 'default' end
        }
      },

      signature = { enabled = true }
    },
  },
}
