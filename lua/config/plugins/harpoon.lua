return {

  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")

    harpoon:setup()

    vim.keymap.set("n", "<leader>A", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = "Harpoon open picker" })

    local keys = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 0 };

    for i = 1, #keys, 1 do
      vim.keymap.set("n", "<leader>" .. keys[i], function() harpoon:list():select(i) end,
      { desc = "Harpoon select file " .. i })
      vim.keymap.set("n", "<leader>h" .. keys[i], function() harpoon:list():replace_at(i) end,
      { desc = "Harpoon replace file " .. i })
    end
  end,

}
