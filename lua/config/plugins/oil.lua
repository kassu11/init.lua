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
          "icon",
        },
        view_options = {
          case_insensitive = true,
          show_hidden = true,
          is_always_hidden = function(name, _)
            return name == "..";
          end,
          sort = {
            { "type", "asc" },
            { "name", "asc" },
          },
        },
        win_options = {
          wrap = true,
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
          ["<leader>cc"] = { "actions.cd", mode = "n" },
          ["<leader>E"] = {
            function()
              local path = oil.get_current_dir()
              local entry = oil.get_cursor_entry();

              if entry ~= nil and entry.name ~= nil then
                vim.cmd("silent !start explorer /select," .. path .. "\"" .. entry.name)
              else
                vim.cmd("silent !start explorer " .. path)
              end
            end,
            nowait = true,
            desc = "Open current buff directory"
          },
          ["<leader>O"] = function()
            local path = oil.get_current_dir()
            vim.cmd("silent !start /I cmd /K \"cd /d " .. path .. "\"")
          end,
          ["<leader>gb"] = function()
            builtin.git_branches { cwd = oil.get_current_dir() }
          end,
          ["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
          ["gs"] = { "actions.change_sort", mode = "n" },
          ["gx"] = "actions.open_external",
          ["g."] = { "actions.toggle_hidden", mode = "n" },
          ["g\\"] = { "actions.toggle_trash", mode = "n" },
          ["<leader>sf"] = {
            function()
              require("telescope.builtin").find_files({
                cwd = oil.get_current_dir()
              })
            end,
            nowait = true,
            desc = "Find files in the current directory"
          },
          ["<leader>sg"] = {
            function()
              require("telescope.builtin").live_grep({
                cwd = oil.get_current_dir()
              })
            end,
            nowait = true,
            desc = "Search by Grep in the current directory"
          },
        },
      }
    end,
  }
}
