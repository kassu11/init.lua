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

      vim.keymap.set("n", "<M-a>", function() harpoon:list():select(4) end, { desc = "Harpoon select file 4" })
      vim.keymap.set("n", "<M-s>", function() harpoon:list():select(3) end, { desc = "Harpoon select file 3" })
      vim.keymap.set("n", "<M-d>", function() harpoon:list():select(2) end, { desc = "Harpoon select file 2" })
      vim.keymap.set("n", "<M-f>", function() harpoon:list():select(1) end, { desc = "Harpoon select file 1" })

      vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end, { desc = "Harpoon previous file" })
      vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end, { desc = "Harpoon next file" })
      vim.keymap.set("n", "<M-å>p", function() harpoon:list():prev() end, { desc = "Harpoon previous file (cmd remap)" })
      vim.keymap.set("n", "<M-å>n", function() harpoon:list():next() end, { desc = "Harpoon next file (cmd remap)" })
    end,
  }
}
