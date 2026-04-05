return {
  "neovim/nvim-lspconfig",
  config = function()
    vim.lsp.enable { "lua_ls", "clangd", "ts_ls", "cssls", "css_variables" }

    vim.lsp.config("lua_ls", {
      settings = {
        Lua = {
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true)
          }
        }
      }
    })

    vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { desc = "Format file" })

    vim.keymap.set("n", "grd", vim.lsp.buf.declaration, { desc = "Goto Declaration" })

    vim.keymap.set("n", "<M-e>", vim.diagnostic.open_float, { desc = "Show diagnostic Error messages" })
    vim.keymap.set("n", "€", vim.diagnostic.open_float, { desc = "Show diagnostic Error messages" })

    vim.keymap.set({ "n", "x" }, "gra", vim.lsp.buf.code_action, { desc = "Code Action" })
    vim.keymap.set("n", "ge", function() vim.diagnostic.jump { count = 1, float = true } end,
      { desc = "Goto next error message" })
    vim.keymap.set("n", "gE", function() vim.diagnostic.jump { count = -1, float = true } end,
      { desc = "Goto previous error message" })
  end,
}
