return {
  {
    "booperlv/nvim-gomove",
    enabled = true,
    config = function()
      local set = vim.keymap.set
      local keep_cursor = function(string)
        return function()
          if vim.api.nvim_get_mode().mode == "V" then
            return string .. "gv"
          end
          return string
        end
      end

      set("n", "<M-h>", "<Plug>GoNSMLeft", { desc = "Move char left" })
      set("n", "<M-j>", "<Plug>GoNSMDown", { desc = "Move line down" })
      set("n", "<M-k>", "<Plug>GoNSMUp", { desc = "Move line up" })
      set("n", "<M-l>", "<Plug>GoNSMRight", { desc = "Move char right" })

      set("x", "<M-h>", "<Plug>GoVSMLeft", { desc = "Move selection left" })
      set("x", "<M-j>", keep_cursor"<Plug>GoVSMDown", { expr = true, desc = "Move selection down" })
      set("x", "<M-k>", keep_cursor"<Plug>GoVSMUp", { expr = true, desc = "Move selection up" })
      set("x", "<M-l>", "<Plug>GoVSMRight", { desc = "Move selection right" })

      set("n", "<M-S-h>", "<Plug>GoNSDLeft", { desc = "Duplicate selection left" })
      set("n", "<M-S-j>", "<Plug>GoNSDDown", { desc = "Duplicate line down" })
      set("n", "<M-S-k>", "<Plug>GoNSDUp", { desc = "Duplicate line up" })
      set("n", "<M-S-l>", "<Plug>GoNSDRight", { desc = "Duplicate selection right" })

      set("x", "<M-S-h>", "<Plug>GoVSDLeft", { desc = "Duplicate selection left" })
      set("x", "<M-S-j>", "<Plug>GoVSDDown", { desc = "Duplicate selection down" })
      set("x", "<M-S-k>", "<Plug>GoVSDUp", { desc = "Duplicate selection up" })
      set("x", "<M-S-l>", "<Plug>GoVSDRight", { desc = "Duplicate selection right" })
    end,
  },
}
