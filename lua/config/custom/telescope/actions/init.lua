local actions = require "telescope.actions"
local utils = require "telescope.utils"
local action_state = require "telescope.actions.state"

local custom_actions = {}

custom_actions.git_apply_stash = function(prompt_bufnr)
  local selection = action_state.get_selected_entry()
  if selection == nil then
    utils.__warn_no_selection "custom_actions.git_apply_stash"
    return
  end

  actions.close(prompt_bufnr)
  local _, ret, stderr = utils.get_os_command_output { "git", "stash", "apply", "--index", selection.value }
  if ret == 0 then
    vim.cmd [[:Gedit]]
    vim.cmd [[:Gedit]]
    utils.notify("custom_actions.git_apply_stash", {
      msg = string.format("applied: '%s' ", selection.value),
      level = "INFO",
    })
  else
    utils.notify("custom_actions.git_apply_stash", {
      msg = string.format("Error when applying: %s. Git returned: '%s'", selection.value, table.concat(stderr, " ")),
      level = "ERROR",
    })
  end
end


custom_actions.git_create_stash = function(prompt_bufnr)
  local cwd = action_state.get_current_picker(prompt_bufnr).cwd
  local new_stash = action_state.get_current_line()

  if new_stash == "" then
    utils.notify("custom.actions.git_create_stash", {
      msg = "Missing the new stash name",
      level = "ERROR",
    })
  else
    local confirmation = vim.fn.input(string.format("Create new stash '%s'? [y/n]: ", new_stash))
    if string.len(confirmation) == 0 or string.sub(string.lower(confirmation), 0, 1) ~= "y" then
      utils.notify("custom.actions.git_create_stash", {
        msg = string.format("fail to create stash: '%s'", new_stash),
        level = "ERROR",
      })
      return
    end

    actions.close(prompt_bufnr)

    local _, ret, stderr = utils.get_os_command_output({ "git", "stash", "-u", "-m", new_stash }, cwd)
    if ret == 0 then
      vim.cmd [[:Gedit]]
      vim.cmd [[:Gedit]]
      utils.notify("custom.actions.git_create_stash", {
        msg = string.format("Created a new stash: %s", new_stash),
        level = "INFO",
      })
    else
      utils.notify("custom.actions.git_create_stash", {
        msg = string.format(
          "Error when creating new stash: '%s' Git returned '%s'",
          new_stash,
          table.concat(stderr, " ")
        ),
        level = "INFO",
      })
    end
  end
end


local drop_stash = function()
  local selection = action_state.get_selected_entry()
  if selection == nil then
    utils.__warn_no_selection "custom_actions.drop_stash"
    return
  end

  local _, ret, stderr = utils.get_os_command_output { "git", "stash", "drop", selection.value }
  if ret == 0 then
    utils.notify("custom_actions.drop_stash", {
      msg = string.format("applied: '%s' ", selection.value),
      level = "INFO",
    })
  else
    utils.notify("custom_actions.drop_stash", {
      msg = string.format("Error when applying: %s. Git returned: '%s'", selection.value, table.concat(stderr, " ")),
      level = "ERROR",
    })
  end
end

custom_actions.git_drop_stash = function(prompt_bufnr)
  local selection = action_state.get_selected_entry()

  if selection == nil then
    utils.__warn_no_selection "custom_actions.git_drop_stash"
    return
  end


  local confirmation = vim.fn.input(string.format("Drop current stash '%s'? [y/n]: ", selection.commit_info))
  if string.len(confirmation) == 0 or string.sub(string.lower(confirmation), 0, 1) ~= "y" then
    utils.notify("custom.actions.git_drop_stash", {
      msg = string.format("fail to drop stash: '%s'", selection.commit_info),
      level = "ERROR",
    })
    return
  end

  drop_stash()
  actions.close(prompt_bufnr)
end

custom_actions.git_replace_stash = function(prompt_bufnr)
  local selection = action_state.get_selected_entry()
  if selection == nil then
    utils.__warn_no_selection "custom_actions.git_replace_stash"
    return
  end

  if selection.commit_info == nil then
    utils.notify("custom_actions.git_replace_stash", {
      msg = string.format("No commit_info found from stash: '%s' ", selection.value),
      level = "WARN",
    })
    return
  end

  local confirmation = vim.fn.input(string.format("Replace selected stash '%s'? [y/n]: ", selection.commit_info))
  if string.len(confirmation) == 0 or string.sub(string.lower(confirmation), 0, 1) ~= "y" then
    utils.notify("custom.actions.git_replace_stash", {
      msg = string.format("fail to replace stash: '%s'", selection.commit_info),
      level = "ERROR",
    })
    return
  end

  drop_stash()
  actions.close(prompt_bufnr)

  local _, ret, stderr = utils.get_os_command_output { "git", "stash", "-u", "-m", selection.commit_info }
  if ret == 0 then
    vim.cmd [[:Gedit]]
    vim.cmd [[:Gedit]]
    utils.notify("custom_actions.git_replace_stash", {
      msg = string.format("applied: '%s' ", selection.commit_info),
      level = "INFO",
    })
  else
    utils.notify("custom_actions.git_replace_stash", {
      msg = string.format("Error when applying: %s. Git returned: '%s'", selection.commit_info, table.concat(stderr, " ")),
      level = "ERROR",
    })
  end
end

return custom_actions
