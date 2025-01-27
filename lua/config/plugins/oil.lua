return {
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local oil = require "oil"
      vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent with oil directory" })

      oil.setup {
        default_file_explorer = true,
        columns = {
          "icon",
        },
        win_options = {
          signcolumn = "yes:2",
        },
        keymaps = {
          ["g?"] = { "actions.show_help", mode = "n" },
          ["<CR>"] = "actions.select",
          ["<C-y>"] = "actions.select",
          ["<C-s>"] = { "actions.select", opts = { vertical = true } },
          ["<C-h>"] = { "actions.select", opts = { horizontal = true } },
          ["<C-t>"] = { "actions.select", opts = { tab = true } },
          ["<C-p>"] = "actions.preview",
          ["<C-c>"] = { "actions.close", mode = "n" },
          ["<C-l>"] = "actions.refresh",
          ["-"] = { "actions.parent", mode = "n" },
          ["_"] = { "actions.open_cwd", mode = "n" },
          ["<leader>c"] = { "actions.cd", mode = "n" },
          ["<leader>O"] = function()
            local path = oil.get_current_dir()
            vim.cmd("silent !start /I cmd /K \"cd /d " .. path .. "\"")
          end,
          ["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
          ["gs"] = { "actions.change_sort", mode = "n" },
          ["gx"] = "actions.open_external",
          ["g."] = { "actions.toggle_hidden", mode = "n" },
          ["g\\"] = { "actions.toggle_trash", mode = "n" },
        },
        view_options = {
          case_insensitive = true,
          sort = {
            { "type", "asc" },
            { "name", "asc" },
          },
        }
      }
    end,
  }
}
