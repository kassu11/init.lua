-- Open file(s) on drag and drop
-- Windows Terminal drops multiple files as a single line, paths separated by
-- spaces, with any path containing a space wrapped in double quotes.
local function tokenize_dropped_paths(line)
  local tokens = {}
  local i, n = 1, #line
  while i <= n do
    local c = line:sub(i, i)
    if c == " " then
      i = i + 1
    elseif c == '"' then
      local close = line:find('"', i + 1, true)
      if not close then
        return nil -- unterminated quote, not a path list we understand
      end
      table.insert(tokens, line:sub(i + 1, close - 1))
      i = close + 1
    else
      local space = line:find(" ", i, true)
      if space then
        table.insert(tokens, line:sub(i, space - 1))
        i = space + 1
      else
        table.insert(tokens, line:sub(i))
        i = n + 1
      end
    end
  end
  return tokens
end


vim.paste = (function(overridden)
  return function(lines, phase)
    if vim.fn.mode() == "n" and #lines == 1 and #lines[1] <= 10000 then
      local tokens = tokenize_dropped_paths(lines[1])
      local paths = {}
      local valid = tokens ~= nil

      if valid then
        for _, path in ipairs(tokens) do
          if vim.fn.filereadable(path) == 1 or vim.fn.isdirectory(path) == 1 then
            table.insert(paths, path)
          else
            valid = false
            break
          end
        end
      end

      if valid and #paths > 0 then
        vim.schedule(function()
          for _, path in ipairs(paths) do
            vim.cmd.vsplit(vim.fn.fnameescape(path))
          end
        end)
        return false
      end
    end

    return overridden(lines, phase)
  end
end)(vim.paste)

