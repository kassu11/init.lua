local actions = require "telescope.actions"
local custom_actions = require "config.custom.telescope.actions"
local finders = require "telescope.finders"
local make_entry = require "telescope.make_entry"
local pickers = require "telescope.pickers"
local previewers = require "telescope.previewers"
local utils = require "telescope.utils"

local conf = require("telescope.config").values

local git = {}

git.stash = function(opts)
  opts = vim.F.if_nil(opts, {})
  opts.show_branch = vim.F.if_nil(opts.show_branch, true)
  opts.entry_maker = vim.F.if_nil(opts.entry_maker, make_entry.gen_from_git_stash(opts))

  pickers
      .new(opts, {
        prompt_title = "Git Stash",
        finder = finders.new_oneshot_job(
          utils.flatten {
            "git",
            "--no-pager",
            "stash",
            "list",
          },
          opts
        ),
        previewer = previewers.git_stash_diff.new(opts),
        sorter = conf.file_sorter(opts),
        attach_mappings = function(_, map)
          actions.select_default:replace(custom_actions.git_apply_stash)
          map({ "i", "n" }, "<c-c>", custom_actions.git_create_stash)
          map({ "i", "n" }, "<c-s>", custom_actions.git_replace_stash)
          map({ "i", "n" }, "<c-x>", custom_actions.git_drop_stash)
          return true
        end,
      })
      :find()
end

return git
