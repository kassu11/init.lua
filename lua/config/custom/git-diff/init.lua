-- local windows = vim.api.nvim_list_wins()
--
-- -- Switch to the second window (if it exists)
-- if #windows > 3 then
--     vim.api.nvim_set_current_win(windows[3])
-- end
--
--
-- local function is_window_in_diff_mode(win_id)
--     return vim.api.nvim_win_get_option(win_id, "diff")
-- end

-- Example: Check if the current window is in diff mode
-- local current_win = vim.api.nvim_get_current_win()
-- if is_window_in_diff_mode(current_win) then
--   print("Window is in diff mode")
-- else
--   print("Window is NOT in diff mode")
-- end
--
--vim.keymap.set("n", "<leader>t", function()
--     print("Hello, buffer!")
-- end, { buffer = 0, noremap = true, silent = true })


-- vim.cmd("diffthis")
-- vim.cmd("diffthis")


local maps = {
  ["open_diff"] = "<leader>gd",
  ["next_diff"] = "ä",
  ["prev_diff"] = "ö",
}


local diff = {}


local diff_list = nil
-- 0 index is the original file without any git history
local diff_indices = {}

local add_buf_keymaps = function (bufnro)
  local buf = vim.F.if_nil(bufnro, 0)

  vim.keymap.set("n", maps["next_diff"], function() diff.advance_buf_index(1) end, {buffer = buf})
  vim.keymap.set("n", maps["prev_diff"], function() diff.advance_buf_index(-1) end, {buffer = buf})
end

local change_git_history = function(index)
  local buf = vim.api.nvim_get_current_buf();
  local win = vim.api.nvim_get_current_win();

  if diff_list == nil or index == diff_indices[buf] then
    return
  end
  local entry = diff_list[index]

  if index == 0 then
    vim.api.nvim_command("Gedit")
    add_buf_keymaps(0)
  elseif entry == nil or entry == index then
    return
  elseif index < #diff_list then
    local cursor = vim.api.nvim_win_get_cursor(win)
    local view = vim.fn.winsaveview()
    vim.api.nvim_win_set_buf(win, vim.fn.bufnr(entry.bufnr))
    diff_indices[buf] = nil
    diff_indices[entry.bufnr] = index
    add_buf_keymaps(entry.bufnr)
    vim.api.nvim_command("diffthis")
    vim.api.nvim_win_set_cursor(win, cursor)
    vim.fn.winrestview(view)
    -- diff.refresh_diff_position()
  end
end

diff.get_diff_window_id = function()
  local windows = vim.api.nvim_list_wins()

  for i = 1, #windows do
    if vim.api.nvim_get_option_value("diff", { win = windows[i] }) then
      return windows[i]
    end
  end
end


diff.advance_buf_index = function(amount)
  local buf = vim.api.nvim_get_current_buf();
  local index = diff_indices[buf]

  if diff_list == nil or index == nil then
    return
  end

  local new_index = index + amount

  if new_index < 0 or new_index > #diff_list then
    return
  end

  change_git_history(new_index)
end

diff.refresh_diff_position = function()
  local current_window = vim.api.nvim_get_current_win()
  local sync_id = diff.get_diff_window_id()
  local cursor = vim.api.nvim_win_get_cursor(sync_id)
  vim.api.nvim_command("diffoff!")
  vim.api.nvim_command("diffthis")
  vim.api.nvim_set_current_win(sync_id)
  vim.api.nvim_command("diffthis")
  vim.api.nvim_set_current_win(current_window)
end


diff.open_diff = function()
  local left_id = vim.api.nvim_get_current_win();
  vim.api.nvim_command("diffthis")
  vim.api.nvim_command("vsplit")
  vim.api.nvim_command("0Gclog")
  vim.api.nvim_command("cclose")

  diff_list = vim.fn.getqflist()
  if #diff_list == 0 then
    vim.api.nvim_command("close")
    vim.api.nvim_command("diffoff")
    print("No git history found")
    return
  end

  local right_buf = vim.api.nvim_get_current_buf();
  vim.api.nvim_command("diffthis")
  vim.api.nvim_set_current_win(left_id)
  local left_buf = vim.api.nvim_get_current_buf();

  diff_indices[right_buf] = 1
  diff_indices[left_buf] = 0

  add_buf_keymaps(right_buf)
  add_buf_keymaps(left_buf)
end

vim.keymap.set("n", "<leader>gd", diff.open_diff);


print(diff.get_diff_window_id())
return diff
