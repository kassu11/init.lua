return {
  {
    'saghen/blink.cmp',
    dependencies = 'rafamadriz/friendly-snippets',
    version = '*',
    opts = {
      keymap = { preset = 'default' },

      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono'
      },

      signature = { enabled = true }
    },
    config = function()
      local signature_trigger = require("blink.cmp.signature.trigger")
      vim.keymap.set("i", "<C-k>", signature_trigger.show, { desc = "Show function signature" })
    end,
  },
}
