return {
  {
    "nvim-telescope/telescope-project.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", {
      "ThePrimeagen/harpoon",
      branch = "harpoon2",
    } },
    config = function()
      local telescope = require "telescope"
      local harpoon = require "harpoon"

      vim.keymap.set("n", "<leader>sp", function()
        telescope.extensions.project.project { display_type = "full", hide_workspace = true }
      end)

      local project_actions = require("telescope._extensions.project.actions")
      local builtin = require "telescope.builtin"
      telescope.setup {
        extensions = {
          project = {
            on_project_selected = function(prompt_bufnr)
              project_actions.change_working_directory(prompt_bufnr, false)
              if harpoon:list():length() > 0 then
                harpoon:list():select(1)
              else
                builtin.find_files()
              end
            end,
            search_by = { "path", "title" }
          }
        }
      }

      telescope.load_extension("project")
    end,
  }
}
