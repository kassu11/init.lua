return {
  "folke/zen-mode.nvim",
  opts = {
    window = {
      options = {
        signcolumn = "no",      -- disable signcolumn
        number = false,         -- disable number column
        relativenumber = false, -- disable relative numbers
        cursorline = false,     -- disable cursorline
        cursorcolumn = false,   -- disable cursor column
        foldcolumn = "0",       -- disable fold column
        list = false,           -- disable whitespace characters
      },
    },
    plugins = {
      -- disable some global vim options (vim.o...)
      -- comment the lines to not apply the options
      options = {
        enabled = true,
        ruler = false, -- disables the ruler text in the cmd line area
        showcmd = false, -- disables the command in the last line of the screen
        -- you may turn on/off statusline in zen mode by setting 'laststatus'
        -- statusline will be shown only if 'laststatus' == 3
        laststatus = 0, -- turn off the statusline in zen mode
      },
    },
    on_open = function(win)
      vim.opt.showmode = false
      vim.opt.laststatus = 0
      vim.opt.cmdheight = 0
    end,
    on_close = function(win)
      vim.opt.showmode = true
      vim.opt.laststatus = 2
      vim.opt.cmdheight = 1
    end
  }
}
