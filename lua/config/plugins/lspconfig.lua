return {
  "neovim/nvim-lspconfig",
  config = function()
    vim.lsp.enable { "lua_ls", "clangd", "cssls", "css_variables", "emmet_ls", "eslint", "zls", "ols", "vtsls", "vue_ls" }

    if vim.fn.has("win32") == 1 then
      vim.lsp.config("ts_ls", { cmd = { "typescript-language-server.cmd", "--stdio" }, })
      vim.lsp.config("vtsls", { cmd = { "vtsls.cmd", "--stdio" }, })
      vim.lsp.config("vue_ls", { cmd = { "vue-language-server.cmd", "--stdio" }, })
    end

    -- Vue hybrid-mode support: vtsls needs to load the @vue/typescript-plugin
    -- so it understands <script> blocks inside .vue files, and its filetypes
    -- need to be extended to include "vue" so it actually attaches there.
    -- The plugin's `location` is resolved from the live vue-language-server
    -- shim rather than hardcoded, since pnpm's global install path for it
    -- changes every reinstall.
    do
      local shim = vim.fn.exepath(vim.fn.has("win32") == 1 and "vue-language-server.cmd" or "vue-language-server")
      local vue_language_server_path
      if shim ~= "" then
        local ok, lines = pcall(vim.fn.readfile, shim)
        if ok then
          local content = table.concat(lines, "\n")
          local js_path = content:match('"([^"]-@vue[\\/]language%-server[\\/]bin[\\/]vue%-language%-server%.js)"')
          if js_path then
            -- .cmd shims reference their own dir as the batch variable
            -- %~dp0 (with trailing slash), which is only expanded by cmd.exe
            -- -- substitute it ourselves since we're just reading the file as text.
            local shim_dir = vim.fn.fnamemodify(shim, ":h") .. "\\"
            js_path = js_path:gsub("^%%~dp0", (shim_dir:gsub("%%", "%%%%")))
            vue_language_server_path = js_path:gsub("[\\/]bin[\\/]vue%-language%-server%.js$", "")

            -- pnpm's global install dir exposes the package through a symlink
            -- (global/v11/<hash>/node_modules/@vue/language-server -> the real
            -- package inside its content-addressable store). tsserver loads
            -- this plugin via `require.resolve("@vue/typescript-plugin", { paths:
            -- [location] })`, and that resolution does NOT walk through the
            -- symlink to find the real package's own node_modules -- it just
            -- fails to find the plugin. tsserver swallows that failure and
            -- silently falls back to parsing the raw .vue SFC as plain
            -- TypeScript, which is what produces the "Cannot find name
            -- 'template'"/"'>' expected" flood. Resolving to the real,
            -- symlink-free path fixes it.
            local real = vim.uv.fs_realpath(vue_language_server_path)
            if real then vue_language_server_path = real end
          end
        end
      end

      if vue_language_server_path then
        vim.lsp.config("vtsls", {
          filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
          settings = {
            vtsls = {
              tsserver = {
                globalPlugins = {
                  {
                    name = "@vue/typescript-plugin",
                    location = vue_language_server_path,
                    languages = { "vue" },
                    configNamespace = "typescript",
                  },
                },
              },
            },
          },
        })
      else
        vim.notify("Could not resolve @vue/language-server path for vtsls's Vue plugin", vim.log.levels.WARN)
      end
    end

    vim.lsp.config("lua_ls", {
      settings = {
        Lua = {
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true)
          }
        }
      }
    })

    vim.lsp.config("ols", {
      init_options = {
        checker_args = "-vet",
        enable_semantic_tokens = true
      },
    })

    vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { desc = "Format file" })
    -- Format visual selection
    vim.keymap.set("v", "<leader>lf", function()
      vim.lsp.buf.format({ range = true })
    end, { desc = "LSP format range" })

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
