return {
  "nvim-mini/mini.files",
  dependencies = { "nvim-tree/nvim-web-devicons", "folke/snacks.nvim" },
  enabled = true,
  config = function()
    local MiniFiles = require "mini.files";

    vim.keymap.set("n", "-", function()
      if not MiniFiles.close() then
        local buf_name = vim.api.nvim_buf_get_name(0)
        local path = vim.fn.filereadable(buf_name) == 1 and buf_name or vim.fn.getcwd()
        MiniFiles.open(path)
        MiniFiles.reveal_cwd()
      end
    end, { desc = "Open Mini Files" })

    local show_dotfiles = true

    local filter_show = function(fs_entry) return true end

    local filter_hide = function(fs_entry)
      return not vim.startswith(fs_entry.name, ".")
    end

    local toggle_dotfiles = function()
      show_dotfiles = not show_dotfiles
      local new_filter = show_dotfiles and filter_show or filter_hide
      MiniFiles.refresh({ content = { filter = new_filter } })
    end

    -- Set focused directory as current working directory
    local set_cwd = function()
      local path = (MiniFiles.get_fs_entry() or {}).path
      if path == nil then return vim.notify('Cursor is not on valid entry') end
      vim.fn.chdir(vim.fs.dirname(path))
    end

    -- Yank in register full path of entry under cursor
    local yank_path = function()
      local path = (MiniFiles.get_fs_entry() or {}).path
      if path == nil then return vim.notify('Cursor is not on valid entry') end
      vim.fn.setreg(vim.v.register, path)
    end

    local map_split = function(buf_id, lhs, direction)
      local rhs = function()
        -- Make new window and set it as target
        local cur_target = MiniFiles.get_explorer_state().target_window
        local new_target = vim.api.nvim_win_call(cur_target, function()
          vim.cmd(direction .. ' split')
          return vim.api.nvim_get_current_win()
        end)

        MiniFiles.set_target_window(new_target)

        -- This intentionally doesn't act on file under cursor in favor of
        -- explicit "go in" action (`l` / `L`). To immediately open file,
        -- add appropriate `MiniFiles.go_in()` call instead of this comment.
      end

      -- Adding `desc` will result into `show_help` entries
      local desc = 'Split ' .. direction
      vim.keymap.set('n', lhs, rhs, { buffer = buf_id, desc = desc })
    end

    -- Open path with system default handler (useful for non-text files)
    local ui_open = function() vim.ui.open(MiniFiles.get_fs_entry().path) end

    local open_explorer = function()
      local path = MiniFiles.get_fs_entry().path
      if vim.loop.os_uname().sysname == "Windows_NT" then
        -- Normalize removes //
        -- Change / to \
        path = vim.fs.normalize(path):gsub("/", "\\");
      end

      vim.cmd("silent !start explorer /select, \"" .. path .. "\"")
    end

    local open_terminal = function()
      local path = vim.fs.dirname(MiniFiles.get_fs_entry().path)
      if vim.loop.os_uname().sysname == "Windows_NT" then
        -- Normalize removes //
        -- Change / to \
        path = vim.fs.normalize(path):gsub("/", "\\");
      end

      vim.cmd("silent !start wt -d \"" .. path .. "\"")
    end

    local open_cwd = function()
      print(vim.fn.getcwd());
      MiniFiles.open(vim.fn.getcwd())
    end

    vim.api.nvim_create_autocmd("User", {
      pattern = "MiniFilesBufferCreate",
      callback = function(args)
        local buf_id = args.data.buf_id
        vim.keymap.set("n", "g.", toggle_dotfiles, { buffer = buf_id, desc = "Toggle hidden files"})

        vim.keymap.set("n", "g~", set_cwd,   { buffer = buf_id, desc = "Set cwd" })
        vim.keymap.set("n", "gX", ui_open,   { buffer = buf_id, desc = "OS open" })
        vim.keymap.set("n", "gX", ui_open,   { buffer = buf_id, desc = "OS open" })
        vim.keymap.set("n", "gy", yank_path, { buffer = buf_id, desc = "Yank path" })
        vim.keymap.set("n", "<leader>e", open_explorer, { buffer = buf_id, desc = "Open explorer" })
        vim.keymap.set("n", "<leader>o", open_terminal, { buffer = buf_id, desc = "Open terminal" })
        vim.keymap.set("n", "_", open_cwd, { buffer = buf_id, desc = "Go to cwd" })
        vim.keymap.set("n", "<C-w><C-q>", function() MiniFiles.close() end, { buffer = buf_id, desc = "Close mini files" })
        vim.keymap.set("n", "<C-w>q", function() MiniFiles.close() end, { buffer = buf_id, desc = "Close mini files" })

        map_split(buf_id, "<C-s>", "belowright horizontal")
        map_split(buf_id, "<C-v>", "belowright vertical")
        map_split(buf_id, "<C-t>", "tab")
      end,
    })

    local set_mark = function(id, path, desc)
      MiniFiles.set_bookmark(id, path, { desc = desc })
    end

    vim.api.nvim_create_autocmd("User", {
      pattern = "MiniFilesExplorerOpen",
      callback = function()
        set_mark("c", vim.fn.stdpath("config"), "Config")
        set_mark("w", vim.fn.getcwd, "Working directory")
        set_mark("~", "~", "Home directory")
      end,
    })

    MiniFiles.setup {
      content = {
        filter = nil,
        highlight = nil,
        prefix = nil,
        sort = nil,
      },

      mappings = {
        close       = '<C-c>',
        go_in       = '',
        go_in_plus  = 'l',
        go_out      = 'h',
        go_out_plus = '',
        mark_goto   = "'",
        mark_set    = 'm',
        reset       = '<BS>',
        reveal_cwd  = '@',
        show_help   = 'g?',
        synchronize = '=',
        trim_left   = '<',
        trim_right  = '>',
      },

      options = {
        permanent_delete = true,
        use_as_default_explorer = true,
        lsp_timeout = 1000,
      },

      windows = {
        max_number = math.huge,
        preview = true,
        width_focus = 50,
        width_nofocus = 15,
        width_preview = 80,
      },
    }
  end,
}
