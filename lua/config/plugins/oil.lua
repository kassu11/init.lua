return {
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", "nvim-telescope/telescope.nvim" },
    config = function()
      local oil = require "oil"
      vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent with oil directory" })

      local builtin = require "telescope.builtin"
      oil.setup {
        default_file_explorer = true,
        columns = {
          "icon", "permissions", "size", "mtime"
        },
        lsp_file_methods = {
          timeout_ms = 1000,
          autosave_changes = "unmodified",
        },
        view_options = {
          case_insensitive = true,
          is_always_hidden = function(name, _)
            return name == "..";
          end,
        },
        win_options = {
          signcolumn = "yes:1",
        },
      }
    end,
  }
}
