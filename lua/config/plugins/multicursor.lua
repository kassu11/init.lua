return {
  {
    "jake-stewart/multicursor.nvim",
    branch = "1.0",
    enabled = true,
    config = function()
      local mc = require("multicursor-nvim")

      mc.setup()

      local set = vim.keymap.set

      set({ "n", "v" }, "<C-k>", function() mc.lineAddCursor(-1) end, { desc = "Add multicursor up" })
      set({ "n", "v" }, "<C-j>", function() mc.lineAddCursor(1) end, { desc = "Add multicursor down" })
      set({ "n", "v" }, "<C-S-k>", function() mc.lineSkipCursor(-1) end, { desc = "Skip multicursor up" })
      set({ "n", "v" }, "<C-S-j>", function() mc.lineSkipCursor(1) end, { desc = "Skip multicursor down" })

      set({ "n", "v" }, "<M-n>", function() mc.matchAddCursor(1) end, { desc = "Add forward match multicursor" })
      set({ "n", "v" }, "<M-S-n>", function() mc.matchAddCursor(-1) end, { desc = "Add backward match multicursor" })
      set({ "n", "v" }, "<leader>n", function() mc.matchSkipCursor(1) end, { desc = "Skip forward match multicursor" })
      set({ "n", "v" }, "<leader>N", function() mc.matchSkipCursor(-1) end, { desc = "Skip backward match multicursor" })

      set({ "n", "v" }, "<M-a>", mc.matchAllAddCursors, { desc = "Match add all multicursor" })

      set({ "n", "v" }, "<M-x>", mc.deleteCursor, { desc = "Delete multicursor" })
      set("n", "<c-leftmouse>", mc.handleMouse)
      set({ "n", "v" }, "<c-q>", mc.toggleCursor, { desc = "Toggle multicursor" })

      set("n", "<leader>gv", mc.restoreCursors, { desc = "Restore multicursors" })

      set("n", "<M-S-a>", mc.alignCursors, { desc = "Align multicursor" })

      set("v", "<S-s>", mc.splitCursors, { desc = "Split multicursor" })
      set("v", "<S-m>", mc.matchCursors, { desc = "Match multicursor" })

      set("v", "<leader>t", function() mc.transposeCursors(1) end, { desc = "Transpose multicursor forward" })
      set("v", "<leader>T", function() mc.transposeCursors(-1) end, { desc = "Transpose multicursor backward" })

      set("n", "<esc>", function()
        if not mc.cursorsEnabled() then
          mc.enableCursors()
        elseif mc.hasCursors() then
          mc.clearCursors()
        else
          vim.cmd [[ nohlsearch ]]
        end
      end, { desc = "Enable multicursor, clear multicursor, clear search" })
    end
  },
}
