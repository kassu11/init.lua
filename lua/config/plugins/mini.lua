return {
  {
    'echasnovski/mini.nvim',
    enabled = false,
    config = function()
      local surround = require 'mini.surround'
      surround.setup {
        mappings = {
          add = '<C-s>a',       -- Add surrounding in Normal and Visual modes
          delete = 'ds',        -- Delete surrounding
          find = '<C-s>f',      -- Find surrounding (to the right)
          find_left = '<C-s>F', -- Find surrounding (to the left)
          highlight = '<C-s>h', -- Highlight surrounding
          replace = 'cs',       -- Replace surrounding
          update_n_lines = '',  -- Update `n_lines`

          suffix_last = 'l',    -- Suffix to search with "prev" method
          suffix_next = 'n',    -- Suffix to search with "next" method
        },

        -- Number of lines within which surrounding is searched
        n_lines = 1500,
      }

      -- local ai = require 'mini.ai'
      -- ai.setup {
      --   n_lines = 1500,
      --   -- How to search for object (first inside current line, then inside
      --   -- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
      --   -- 'cover_or_nearest', 'next', 'previous', 'nearest'.
      --   search_method = 'cover_or_prev',
      -- }
    end
  }
}
