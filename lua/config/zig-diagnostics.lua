local M = {}
local ns = vim.api.nvim_create_namespace("zig-build-check")
local jobs = {}
local published = {}

function M.check(buf)
  local root = vim.fs.root(buf, "build.zig")
  if not root then return end
  if jobs[root] then jobs[root]:kill(15) end
  local job
  job = vim.system({ "zig", "build", "check", "--color", "off" }, {
    cwd = root,
    text = true,
  }, vim.schedule_wrap(function(result)
    if jobs[root] ~= job then return end
    jobs[root] = nil
    local diagnostics = {}
    for line in (result.stderr or ""):gmatch("[^\r\n]+") do
      local path, row, col, kind, message = line:match("^(.-):(%d+):(%d+): (%w+): (.*)$")
      if path and (kind == "error" or kind == "warning") then
        if not path:match("^%a:[/\\]") and not path:match("^[/\\]") then
          path = root .. "/" .. path
        end
        local target = vim.fn.bufadd(vim.fs.normalize(path))
        diagnostics[target] = diagnostics[target] or {}
        table.insert(diagnostics[target], {
          lnum = tonumber(row) - 1,
          col = tonumber(col) - 1,
          message = message,
          severity = kind == "error" and vim.diagnostic.severity.ERROR or vim.diagnostic.severity.WARN,
          source = "zig build check",
        })
      end
    end
    for target in pairs(published[root] or {}) do
      vim.diagnostic.reset(ns, target)
    end
    published[root] = diagnostics
    for target, items in pairs(diagnostics) do
      vim.diagnostic.set(ns, target, items)
    end
    if result.code ~= 0 and next(diagnostics) == nil then
      vim.notify("zig build check failed:\n" .. (result.stderr or ""), vim.log.levels.WARN)
    end
  end))
  jobs[root] = job
end

function M.setup()
  local group = vim.api.nvim_create_augroup("ZigBuildDiagnostics", { clear = true })
  vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost" }, {
    group = group,
    pattern = { "*.zig", "build.zig.zon" },
    callback = function(args) M.check(args.buf) end,
  })
end

return M
