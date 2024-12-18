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
          file_ignore_patterns = {
            "node_modules/",
            ".git/"
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
      vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "Search Select Telescope" })
      vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "Search current Word" })
      vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "Search by Grep" })
      vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "Search Diagnostics" })
      vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "Search Resume" })
      vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = "Search Recent Files (\".\" for repeat)" })
      vim.keymap.set("n", "<leader>sb", builtin.buffers, { desc = "Find existing buffers" })

      vim.keymap.set("n", "<leader>sn", function()
        builtin.find_files { cwd = vim.fn.stdpath "config" }
      end, { desc = "Search Neovim files" })
    end,
  },
}
