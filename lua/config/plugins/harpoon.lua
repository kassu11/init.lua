return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local harpoon = require("harpoon")

      ---@diagnostic disable-next-line: missing-parameter
      harpoon:setup()

      vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { desc = "Harpoon add file" })
      vim.keymap.set("n", "<leader>A", function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end, { desc = "Harpoon open picker" })

      vim.keymap.set("n", "<M-f>", function() harpoon:list():select(1) end, { desc = "Harpoon select file 1" })
      vim.keymap.set("n", "<M-d>", function() harpoon:list():select(2) end, { desc = "Harpoon select file 2" })
      vim.keymap.set("n", "<M-s>", function() harpoon:list():select(3) end, { desc = "Harpoon select file 3" })
      vim.keymap.set("n", "<M-a>", function() harpoon:list():select(4) end, { desc = "Harpoon select file 4" })
      vim.keymap.set("n", "<M-r>", function() harpoon:list():select(5) end, { desc = "Harpoon select file 5" })
      vim.keymap.set("n", "<M-w>", function() harpoon:list():select(6) end, { desc = "Harpoon select file 6" })
      vim.keymap.set("n", "<M-q>", function() harpoon:list():select(7) end, { desc = "Harpoon select file 7" })
      vim.keymap.set("n", "<M-t>", function() harpoon:list():select(8) end, { desc = "Harpoon select file 8" })
      vim.keymap.set("n", "<M-c>", function() harpoon:list():select(9) end, { desc = "Harpoon select file 9" })
      vim.keymap.set("n", "<M-v>", function() harpoon:list():select(10) end, { desc = "Harpoon select file 10" })

      vim.keymap.set("n", "<M-F>", function() harpoon:list():replace_at(1) end, { desc = "Harpoon replace file 1" })
      vim.keymap.set("n", "<M-D>", function() harpoon:list():replace_at(2) end, { desc = "Harpoon replace file 2" })
      vim.keymap.set("n", "<M-S>", function() harpoon:list():replace_at(3) end, { desc = "Harpoon replace file 3" })
      vim.keymap.set("n", "<M-A>", function() harpoon:list():replace_at(4) end, { desc = "Harpoon replace file 4" })
      vim.keymap.set("n", "<M-R>", function() harpoon:list():replace_at(5) end, { desc = "Harpoon replace file 5" })
      vim.keymap.set("n", "<M-W>", function() harpoon:list():replace_at(6) end, { desc = "Harpoon replace file 6" })
      vim.keymap.set("n", "<M-Q>", function() harpoon:list():replace_at(7) end, { desc = "Harpoon replace file 7" })
      vim.keymap.set("n", "<M-T>", function() harpoon:list():replace_at(8) end, { desc = "Harpoon replace file 8" })
      vim.keymap.set("n", "<M-C>", function() harpoon:list():replace_at(9) end, { desc = "Harpoon replace file 9" })
      vim.keymap.set("n", "<M-V>", function() harpoon:list():replace_at(10) end, { desc = "Harpoon replace file 10" })

      vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end, { desc = "Harpoon previous file" })
      vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end, { desc = "Harpoon next file" })
      vim.keymap.set("n", "<M-å>p", function() harpoon:list():prev() end, { desc = "Harpoon previous file (cmd remap)" })
      vim.keymap.set("n", "<M-å>n", function() harpoon:list():next() end, { desc = "Harpoon next file (cmd remap)" })

      -- Load first file on NeoVim opening
      if harpoon:list():length() > 0 then
        harpoon:list():select(1)
      end
    end,
  }
}
