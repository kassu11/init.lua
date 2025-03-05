return {
  {

    "nvim-telescope/telescope.nvim",
    event = "VimEnter",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make", },
      { "nvim-telescope/telescope-ui-select.nvim" },
      { "nvim-tree/nvim-web-devicons",              enabled = vim.g.have_nerd_font },
    },
    config = function()
      require("telescope").setup({
        defaults = {
          mappings = {
            i = {
              ["<C-j>"] = require('telescope.actions').cycle_history_next,
              ["<C-k>"] = require('telescope.actions').cycle_history_prev,
            },
          },
          -- prompt_prefix = " ",
          -- selection_caret = " ",
          path_display = { "smart" },
          dynamic_preview_title = true,
          sorting_strategy = "ascending",
          layout_strategy = "vertical",
          layout_config = {
            prompt_position = "top",
            height = 0.95,
          },
          file_ignore_patterns = {
            "^node_modules/",
            "^node_modules\\",
            ".git/",
            ".git\\"
          }
        },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown(),
          },
          fzf = {},
        },
      })

      pcall(require("telescope").load_extension, "fzf")
      pcall(require("telescope").load_extension, "ui-select")

      local builtin = require "telescope.builtin"

      vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "Search Help" })
      vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "Search Keymaps" })

      vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "Search Files" })
      vim.keymap.set("n", "<leader>sF", function()
        builtin.find_files { cwd = vim.fn.expand('%:p:h') }
      end, { desc = "Search Files (current buff path)" })

      vim.keymap.set("n", "<leader>sA", function()
        builtin.find_files { cwd = vim.fn.expand('%:p:h'), no_ignore = true }
      end, { desc = "Search All Files (current buff path)" })
      vim.keymap.set("n", "<leader>sa", function()
        builtin.find_files { no_ignore = true }
      end, { desc = "Search All Files" })

      vim.keymap.set("n", "<leader>sE", function()
        builtin.oldfiles { only_cwd = true }
      end, { desc = "Search old files (current cwd)" })
      vim.keymap.set("n", "<leader>se", builtin.oldfiles, { desc = "Search old files" })

      vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "Search Select Telescope" })
      vim.keymap.set("n", "<leader>sy", builtin.symbols, { desc = "Search symbols" })
      vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "Search current Word" })
      vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "Search by Grep" })
      vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "Search Diagnostics" })
      vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "Search Resume" })
      vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = "Search Recent Files (\".\" for repeat)" })
      vim.keymap.set("n", "<leader>sb", builtin.buffers, { desc = "Find existing buffers" })

      vim.keymap.set("n", "<leader>sn", function()
        builtin.find_files { cwd = vim.fn.stdpath "config" }
      end, { desc = "Search Neovim files" })


      vim.keymap.set("n", "<leader>gb", function()
        builtin.git_branches { cwd = vim.fn.expand("%:p:h") }
      end, { desc = "Search git branches" })

      vim.keymap.set("n", "<leader>gs", function()
        require("config.custom.telescope.builtin").git_stash { cwd = vim.fn.expand("%:p:h") }
      end, { desc = "Search git stash" })

      vim.keymap.set("n", "<leader>gc", function()
        builtin.git_commits { cwd = vim.fn.expand("%:p:h") }
      end, { desc = "Search git commits" })


      print()
    end
  },
}
