return {
  {
    "nvim-telescope/telescope-project.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      local telescope = require "telescope"

      vim.keymap.set("n", "<leader>sp", function() vim.cmd("Telescope project") end)

      local project_actions = require("telescope._extensions.project.actions")
      local builtin = require "telescope.builtin"
      telescope.setup {
        extensions = {
          project = {
            on_project_selected = function(prompt_bufnr)
              project_actions.change_working_directory(prompt_bufnr, false)
              builtin.oldfiles { only_cwd = true }
            end,
          }
        }
      }

      telescope.load_extension("project")
    end,
  }
}
