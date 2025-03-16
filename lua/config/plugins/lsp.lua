return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      'saghen/blink.cmp',
      {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
          library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },
    config = function()
      local capabilities = require('blink.cmp').get_lsp_capabilities();
      require "lspconfig".lua_ls.setup { capabilities = capabilities }
      require "lspconfig".zls.setup { capabilities = capabilities }
      -- require "lspconfig".denols.setup { capabilities = capabilities }
      require 'lspconfig'.ts_ls.setup { capabilities = capabilities }
      -- require 'lspconfig'.biome.setup { capabilities = capabilities }
      require 'lspconfig'.html.setup { capabilities = capabilities }
      require 'lspconfig'.jsonls.setup { capabilities = capabilities }
      require 'lspconfig'.cssls.setup { capabilities = capabilities }
      require 'lspconfig'.emmet_ls.setup { capabilities = capabilities }
      require 'lspconfig'.emmet_language_server.setup { capabilities = capabilities }

      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = args.buf, desc = 'LSP: ' .. desc })
          end

          map('gd', require('telescope.builtin').lsp_definitions, 'Goto Definition')
          map('grr', require('telescope.builtin').lsp_references, 'Goto References')
          map('gI', require('telescope.builtin').lsp_implementations, 'Goto Implementation')
          map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type Definition')
          map('<leader>sds', require('telescope.builtin').lsp_document_symbols, 'Document Symbols')
          map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Workspace Symbols')
          map('<leader>ca', vim.lsp.buf.code_action, 'Code Action', { 'n', 'x' })
          map('gD', vim.lsp.buf.declaration, 'Goto Declaration')
          map('ge', function() vim.diagnostic.jump { count = 1, float = true } end, 'Goto next error message')
          map('gE', function() vim.diagnostic.jump { count = -1, float = true } end, 'Goto previous error message')

          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client then return end

          ---@diagnostic disable-next-line: param-type-mismatch
          if client.supports_method('textDocument/formatting') then
            vim.keymap.set("v", "<leader>f", function()
              local start_pos = vim.fn.getpos("'<")
              local end_pos = vim.fn.getpos("'>")

              if not start_pos or not end_pos then
                print("Error: Could not get selection range.")
                return
              end

              -- Convert to 0-based indexing for LSP
              local start_line = start_pos[2] - 1
              local start_col = start_pos[3] - 1
              local end_line = end_pos[2] - 1
              local end_col = end_pos[3]

              -- Ensure valid range (swap if reversed)
              if start_line > end_line or (start_line == end_line and start_col > end_col) then
                start_line, end_line = end_line, start_line
                start_col, end_col = end_col, start_col
              end

              vim.lsp.buf.format({
                id = client.id,
                range = {
                  ["start"] = { start_line, start_col },
                  ["end"] = { end_line, end_col }
                }
              })

              vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "v", false)
            end, { desc = "Format selection" })
            vim.keymap.set("n", "<leader>f", "V<leader>f", { remap = true, desc = "Format selection" })

            vim.keymap.set("n", "<leader><leader>f", function()
              vim.lsp.buf.format { bufnr = args.buf, id = client.id, }
              print("File formated")
            end, { desc = "Format current buffer" })
          end
        end,
      })
    end,
  }
}
