return {
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

      require "oil".setup {
        default_file_explorer = true,
        columns = {
          "icon",
        },
        keymaps = {
          ["g?"] = { "actions.show_help", mode = "n" },
          ["<CR>"] = "actions.select",
          ["<C-y>"] = "actions.select",
          ["<C-s>"] = false,
          ["<C-h>"] = false,
          ["<C-t>"] = false,
          -- ["<C-s>"] = { "actions.select", opts = { vertical = true } },
          -- ["<C-h>"] = { "actions.select", opts = { horizontal = true } },
          -- ["<C-t>"] = { "actions.select", opts = { tab = true } },
          ["<C-p>"] = "actions.preview",
          ["<C-c>"] = { "actions.close", mode = "n" },
          ["<C-l>"] = false,
          -- ["<C-l>"] = "actions.refresh",
          ["-"] = { "actions.parent", mode = "n" },
          ["_"] = { "actions.open_cwd", mode = "n" },
          ["<leader>c"] = { "actions.cd", mode = "n" },
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
