return {
  {
    "tpope/vim-fugitive",
    config = function()
      vim.keymap.set("n", "<leader>gd", ":Gdiffsplit!<CR>", { desc = ":Git diff" })
      vim.keymap.set("n", "<leader>gl", ":0Gclog<CR>", { desc = ":0Gclog" })
      vim.keymap.set("n", "<leader>gL", ":Gclog<CR>", { desc = ":Gclog" })
      vim.keymap.set("n", "<leader>ge", ":Gedit<CR>", { desc = ":Gedit" })
      vim.keymap.set("n", "<leader>go", function()
        local url = vim.api.nvim_exec2("Git remote get-url origin", { output = true })
        if url.output ~= nil and url.output:sub(1, 8) == "https://" then
          vim.cmd("silent !start " .. url.output)
        else
          print("No remote origin found")
        end
      end, { desc = "Git open remote url" })
    end,
  }
}
