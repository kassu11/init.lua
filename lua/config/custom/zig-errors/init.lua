local M = {}

local uv = vim.uv;
local ev = uv.new_fs_event();


-- Doesn't work on windows
M.start = function()
  uv.fs_event_start(ev, "last_compile_errors.txt", {}, vim.schedule_wrap(function() vim.cmd.cfile("last_compile_errors.txt") end));
end;

M.stop = function()
  uv.fs_event_stop(ev);
end

local show_errors = false;

M.toggle = function()
  if show_errors then
    M.stop();
  else
    M.start();
  end

  show_errors = not show_errors;
end

vim.keymap.set("n", "<leader>ze", function() vim.cmd.cfile("last_compile_errors.txt") end, { desc = "Toggle zig error quick list" });

return M;
