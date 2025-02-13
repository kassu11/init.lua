return {
  {
    "jake-stewart/multicursor.nvim",
    branch = "1.0",
    enabled = true,
    config = function()
      local mc = require("multicursor-nvim")

      mc.setup()

      local count = function(func)
        return function()
          if vim.v.count == 0 then
            func()
          else
            for _ = 1, vim.v.count do
              func()
            end
          end
        end
      end

      local set = vim.keymap.set
      set({ "n", "v" }, "<C-k>", count(function() mc.lineAddCursor(-1) end),
        { desc = "Add multicursor up" })
      set({ "n", "v" }, "<C-j>", count(function() mc.lineAddCursor(1) end),
        { desc = "Add multicursor down" })
      set({ "n", "v" }, "<C-S-k>", count(function() mc.lineSkipCursor(-1) end),
        { desc = "Skip multicursor up" })
      set({ "n", "v" }, "<C-S-j>", count(function() mc.lineSkipCursor(1) end),
        { desc = "Skip multicursor down" })

      set({ "n", "v" }, "<M-n>", count(function() mc.matchAddCursor(1) end),
        { desc = "Add forward match multicursor" })
      set({ "n", "v" }, "<M-S-n>", count(function() mc.matchAddCursor(-1) end),
        { desc = "Add backward match multicursor" })
      set({ "n", "v" }, "<leader>n", count(function() mc.matchSkipCursor(1) end),
        { desc = "Skip forward match multicursor" })
      set({ "n", "v" }, "<leader>N", count(function() mc.matchSkipCursor(-1) end),
        { desc = "Skip backward match multicursor" })

      set({ "n", "v" }, "<M-a>", mc.matchAllAddCursors, { desc = "Match add all multicursor" })

      set({ "n", "v" }, "<M-x>", mc.deleteCursor, { desc = "Delete multicursor" })
      set("n", "<c-leftmouse>", mc.handleMouse)
      set({ "n", "v" }, "<c-q>", mc.toggleCursor, { desc = "Toggle multicursor" })

      set("n", "<leader>gv", mc.restoreCursors, { desc = "Restore multicursors" })

      set("n", "<M-S-a>", mc.alignCursors, { desc = "Align multicursor" })

      set("v", "<leader>s", mc.splitCursors, { desc = "Split multicursor" })
      set("v", "<S-m>", mc.matchCursors, { desc = "Match multicursor" })

      set("v", "<leader>t", count(function() mc.transposeCursors(1) end),
        { desc = "Transpose multicursor forward" })
      set("v", "<leader>T", count(function() mc.transposeCursors(-1) end),
        { desc = "Transpose multicursor backward" })

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
