return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons", "nvim-telescope/telescope.nvim" },
  config = function()
    local oil = require "oil"
    vim.keymap.set("n", "-", function() oil.open() end, { desc = "Open parent with oil directory" })

    local builtin = require "telescope.builtin"

    oil.setup {
      default_file_explorer = true,
      cleanup_delay_ms = 2000,
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
      keymaps = {
        ["<leader>e"] = {
          function()
            local path = oil.get_current_dir()
            local entry = oil.get_cursor_entry();

            if entry ~= nil and entry.name ~= nil then
              vim.cmd("silent !start explorer /select," .. path .. "\"" .. entry.name)
            else
              vim.cmd("silent !start explorer " .. path)
            end
          end,
          desc = "Open current buff directory"
        },
        ["<leader>o"] = function()
          -- Oil path might end with 'A:\Code\project\' <--- remove this character
          local path = oil.get_current_dir():gsub("\\+$", "")
          vim.cmd("silent !start wt -d \"" .. path .. "\"")
        end,
        ["<leader>gb"] = {
          function() builtin.git_branches { cwd = oil.get_current_dir() } end,
          desc = "Switch branches in the current location"
        },
        ["<leader>fd"] = {
          function() builtin.find_files { cwd = oil.get_current_dir(), find_command = { "fd", "-t=d" } } end,
          desc = "Find directory in the current location"
        },
        ["<leader>fw"] = {
          function()
            local input = vim.fn.input("Grep > ")
            if #input > 0 then
              builtin.grep_string { cwd = oil.get_current_dir(), search = input }
            end
          end,
          desc = "Find directory in the current location"
        },
        ["<leader>sf"] = {
          function() builtin.find_files { cwd = oil.get_current_dir() } end,
          desc = "Find files in the current directory"
        },
        ["<leader>sg"] = {
          function() builtin.live_grep { cwd = oil.get_current_dir() } end,
          desc = "Search by Grep in the current directory"
        },
      },
    }
  end,
}
