return {
  "nvim-telescope/telescope-project.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "folke/snacks.nvim",
    { "ThePrimeagen/harpoon", branch = "harpoon2" }
  },
  config = function()
    local telescope = require "telescope"
    local harpoon = require "harpoon"
    local Snacks = require "snacks"

    vim.keymap.set("n", "<leader>sp", function()
      telescope.extensions.project.project { display_type = "full", hide_workspace = true }
    end)

    local project_actions = require "telescope._extensions.project.actions"
    telescope.setup {
      extensions = {
        project = {
          cd_scope = { "window" },
          on_project_selected = function(prompt_bufnr)
            project_actions.change_working_directory(prompt_bufnr, false)
            if harpoon:list():length() > 0 then
              pcall(function() harpoon:list():select(1) end)
            else
              Snacks.picker.files()
            end
          end,
        }
      }
    }

    telescope.load_extension "project"
  end,
}
