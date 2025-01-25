return {
  {
    "brenton-leighton/multiple-cursors.nvim",
    enabled = false,
    version = "*",
    opts = {
      custom_key_maps = {
        { "n", "<C-L>", function() vim.cmd("normal _v$h") end },
        { "v", "<C-L>", function() vim.cmd("normal o_oj$h") end },
        -- vim.keymap.set("n", "<C-L>", "_v$h", { desc = "Select line" });
        -- vim.keymap.set("v", "<C-L>", "o_oj$h", { desc = "Expand line selection" });
      },
    },
    keys = {
      { "<C-j>",         "<Cmd>MultipleCursorsAddDown<CR>",          mode = { "n", "x" },      desc = "Add cursor and move down" },
      { "<C-k>",         "<Cmd>MultipleCursorsAddUp<CR>",            mode = { "n", "x" },      desc = "Add cursor and move up" },

      { "<C-Up>",        "<Cmd>MultipleCursorsAddUp<CR>",            mode = { "n", "i", "x" }, desc = "Add cursor and move up" },
      { "<C-Down>",      "<Cmd>MultipleCursorsAddDown<CR>",          mode = { "n", "i", "x" }, desc = "Add cursor and move down" },

      { "<M-LeftMouse>", "<Cmd>MultipleCursorsMouseAddDelete<CR>",   mode = { "n", "i" },      desc = "Add or remove cursor" },

      -- { "<Leader>a",     "<Cmd>MultipleCursorsAddMatches<CR>",       mode = { "n", "x" },      desc = "Add cursors to cword" },
      -- { "<Leader>A",     "<Cmd>MultipleCursorsAddMatchesV<CR>",      mode = { "n", "x" },      desc = "Add cursors to cword in previous area" },

      { "<M-n>",         "<Cmd>MultipleCursorsAddJumpNextMatch<CR>", mode = { "n", "x" },      desc = "Add cursor and jump to next cword" },
      { "<M-m>",         "<Cmd>MultipleCursorsJumpNextMatch<CR>",    mode = { "n", "x" },      desc = "Jump to next cword" },

      { "<Leader>l",     "<Cmd>MultipleCursorsLock<CR>",             mode = { "n", "x" },      desc = "Lock virtual cursors" },
    },
    config = function(opts)
      vim.api.nvim_set_hl(0, "MultipleCursorsCursor", { bg = "#97ca72", fg = "#000000" })
      vim.api.nvim_set_hl(0, "MultipleCursorsVisual", { bg = "#0398fc", fg = "#000000", })

      require("multiple-cursors").setup(opts)
    end,
  },
}
