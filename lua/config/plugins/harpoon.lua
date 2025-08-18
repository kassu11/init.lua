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

      local keys = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 0 };

      for i = 1, #keys, 1 do
        vim.keymap.set("n", "<leader>" .. keys[i], function() harpoon:list():select(i) end, { desc = "Harpoon select file " .. i })
        vim.keymap.set("n", "<leader>h" .. keys[i], function() harpoon:list():replace_at(i) end, { desc = "Harpoon replace file " .. i })
      end

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
