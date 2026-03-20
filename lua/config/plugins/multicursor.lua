return {
  "jake-stewart/multicursor.nvim",
  branch = "1.0",
  config = function()
    local mc = require("multicursor-nvim")
    mc.setup()

    local set = vim.keymap.set

    -- Add or skip cursor above/below the main cursor.
    set({"n", "x"}, "<C-K>", function() mc.lineAddCursor(-1) end, { desc = "Add multicursor up" })
    set({"n", "x"}, "<C-J>", function() mc.lineAddCursor(1) end, { desc = "Add multicursor down" })
    set({"n", "x"}, "<C-S-K>", function() mc.lineSkipCursor(-1) end, { desc = "Skip multicursor up" })
    set({"n", "x"}, "<C-S-J>", function() mc.lineSkipCursor(1) end, { desc = "Skip multicursor down" })

    -- Add or skip adding a new cursor by matching word/selection
    set({"n", "x"}, "<M-n>", function() mc.matchAddCursor(1) end)
    set({"n", "x"}, "<leader>n", function() mc.matchSkipCursor(1) end)
    set({"n", "x"}, "<M-S-N>", function() mc.matchAddCursor(-1) end)
    set({"n", "x"}, "<leader><S-N>", function() mc.matchSkipCursor(-1) end)

    -- Add and remove cursors with control + left click.
    set("n", "<c-leftmouse>", mc.handleMouse)
    set("n", "<c-leftdrag>", mc.handleMouseDrag)
    set("n", "<c-leftrelease>", mc.handleMouseRelease)

    -- Disable and enable cursors.
    set({"n", "x"}, "<c-q>", mc.toggleCursor)
    set({"n", "x"}, "<leader>q", mc.duplicateCursors)

    set({"n", "v"}, "<leader>ml", mc.matchAllAddCursors, { desc = "Match add all multicursor" })
    set("n", "<leader>gm", mc.restoreCursors, { desc = "Restore multicursors" })
    set("n", "<leader>ma", mc.alignCursors, { desc = "Align multicursor" })
    set("x", "<leader>ms", mc.splitCursors, { desc = "Split multicursor" })
    set("x", "<leader>mm", mc.matchCursors, { desc = "Match multicursor" })
    set("x", "<M-s>", function() mc.matchCursors("$") end, { desc = "Split selection into lines" })
    set("x", "<leader>mt", function() mc.transposeCursors(1) end, { desc = "Transpose multicursor forward" })
    set("x", "<leader>mT", function() mc.transposeCursors(-1) end, { desc = "Transpose multicursor backward" })

    -- Mappings defined in a keymap layer only apply when there are
    -- multiple cursors. This lets you have overlapping mappings.
    mc.addKeymapLayer(function(layerSet)

      -- Select a different cursor as the main one.
      layerSet({"n", "x"}, "<leader>k", mc.prevCursor)
      layerSet({"n", "x"}, "<leader>j", mc.nextCursor)

      -- Delete the main cursor.
      layerSet({"n", "x"}, "<M-x>", mc.deleteCursor)

      set({"n", "x"}, "g<c-a>", mc.sequenceIncrement)
      set({"n", "x"}, "g<c-x>", mc.sequenceDecrement)

      -- Enable and clear cursors using escape.
      layerSet("n", "<esc>", function()
        if not mc.cursorsEnabled() then
          mc.enableCursors()
        else
          mc.clearCursors()
        end
      end)
    end)

    -- Customize how cursors look.
    local hl = vim.api.nvim_set_hl
    hl(0, "MultiCursorCursor", { reverse = true })
    hl(0, "MultiCursorVisual", { link = "Visual" })
    hl(0, "MultiCursorSign", { link = "SignColumn"})
    hl(0, "MultiCursorMatchPreview", { link = "Search" })
    hl(0, "MultiCursorDisabledCursor", { reverse = true })
    hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
    hl(0, "MultiCursorDisabledSign", { link = "SignColumn"})
  end
}

