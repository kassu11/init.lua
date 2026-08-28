return {
  "tpope/vim-fugitive",
  config = function()
    vim.keymap.set("n", "gb", ":Git blame -w --date=format:\"%Y-%m-%d %H:%M\" <CR>", { desc = ":Git diff" })
    vim.keymap.set("n", "<leader>gd", ":Gdiffsplit!<CR>", { desc = ":Git diff" })
    vim.keymap.set("n", "<leader>gl", ":0Gclog<CR>", { desc = "Open current file git history to quickfix list" })
    vim.keymap.set("n", "<leader>gL", ":Gclog<CR>", { desc = "Open git log history to quickfix list" })
    vim.keymap.set("n", "<leader>ge", ":Gedit<CR>", { desc = ":Gedit" })
    vim.keymap.set("n", "<leader>go", function()
      local url = vim.api.nvim_exec2("Git remote get-url origin", { output = true })
      if url.output ~= nil and url.output:sub(1, 8) == "https://" then
        vim.cmd("silent !start " .. url.output)
      else
        print("No remote origin found")
      end
    end, { desc = "Git open remote url" })

    vim.keymap.set("n", "<leader>gO", function()
      local url = vim.api.nvim_exec2("Git remote get-url origin", { output = true })
      local branch = vim.api.nvim_exec2("Git rev-parse --abbrev-ref HEAD", { output = true })
      if branch.output == nil then
        return print("No branch detected")
      elseif url.output ~= nil and url.output:sub(1, 8) == "https://" then
        local fixedUrl = url.output
        if fixedUrl:sub(-4, -1) == ".git" then
          fixedUrl = fixedUrl:sub(1, -5)
        end
        local path = vim.fn.expand('%')
        vim.cmd("silent !start " .. fixedUrl .. "/blob/" .. branch.output .. "/" .. path)
      else
        print("No remote origin found")
      end
    end, { desc = "Git open pull request" })

    vim.keymap.set("n", "<leader>gp", function()
      local url = vim.api.nvim_exec2("Git remote get-url origin", { output = true })
      local branch = vim.api.nvim_exec2("Git rev-parse --abbrev-ref HEAD", { output = true })
      if branch.output == nil then
        return print("No branch detected")
      elseif url.output ~= nil and url.output:sub(1, 8) == "https://" then
        local fixedUrl = url.output
        if fixedUrl:sub(-4, -1) == ".git" then
          fixedUrl = fixedUrl:sub(1, -5)
        end
        vim.cmd("silent !start " .. fixedUrl .. "/compare/" .. branch.output .. "?expand=1")
      else
        print("No remote origin found")
      end
    end, { desc = "Git open pull request" })

    -- :Git to submodule
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "fugitive",
      callback = function(args)
        vim.keymap.set("n", "gs", function()
          local ok, escaped = pcall(vim.fn["fugitive#PorcelainCfile"])
          if not ok or escaped == "" then
            return vim.notify("gs: nothing under cursor", vim.log.levels.WARN)
          end

          if vim.fn.isdirectory(vim.fn.expand(escaped)) == 0 then
            return vim.notify("gs: not a submodule", vim.log.levels.WARN)
          end

          vim.cmd("edit " .. escaped .. "/.git")
          vim.cmd("G")
        end, { buffer = args.buf, desc = "Open git submodule status" })
      end,
    })

    -- Color blame timestamps by recency (cold = oldest commit shown, hot = newest),
    -- so the newest commit in the buffer jumps out visually instead of being just
    -- another string. Relies on `gb` above always including at least "HH:MM".
    do
      local ns = vim.api.nvim_create_namespace("fugitive_blame_age")
      local STEPS = 40
      local COLD = { 0x56, 0x5f, 0x89 } -- oldest commit in the buffer
      local HOT = { 0xe0, 0x6c, 0x75 }  -- newest commit in the buffer

      local function mix(a, b, t)
        return math.floor(a + (b - a) * t + 0.5)
      end

      local function define_blame_age_highlights()
        for i = 0, STEPS do
          local t = i / STEPS
          vim.api.nvim_set_hl(0, "FugitiveBlameAge" .. i, {
            fg = string.format(
              "#%02x%02x%02x",
              mix(COLD[1], HOT[1], t),
              mix(COLD[2], HOT[2], t),
              mix(COLD[3], HOT[3], t)
            ),
          })
        end
      end

      -- Returns epoch, 0-indexed start col, end col (exclusive) for the date/time
      -- inside the first "(...)" annotation on the line, or nil if it can't parse.
      local function parse_epoch(line)
        local paren_s, paren_e = line:find("%b()")
        if not paren_s then
          return nil
        end
        local annotation = line:sub(paren_s, paren_e)
        local rel_s, rel_e, y, mo, d, h, mi, sec =
          annotation:find("(%d%d%d%d)%-(%d%d)%-(%d%d)%s+(%d%d):(%d%d):?(%d*)")
        if not rel_s then
          return nil
        end
        local epoch = os.time({
          year = tonumber(y),
          month = tonumber(mo),
          day = tonumber(d),
          hour = tonumber(h),
          min = tonumber(mi),
          sec = sec ~= "" and tonumber(sec) or 0,
        })
        return epoch, paren_s + rel_s - 2, paren_s + rel_e - 1
      end

      local function apply_blame_age(bufnr)
        vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)
        local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
        local infos, min_t, max_t = {}, nil, nil
        for i, line in ipairs(lines) do
          local epoch, col_start, col_end = parse_epoch(line)
          if epoch then
            infos[i] = { epoch = epoch, col_start = col_start, col_end = col_end }
            min_t = (not min_t or epoch < min_t) and epoch or min_t
            max_t = (not max_t or epoch > max_t) and epoch or max_t
          end
        end
        if not min_t then
          return
        end
        local span = max_t - min_t
        for i, info in pairs(infos) do
          local t = span > 0 and (info.epoch - min_t) / span or 1
          vim.api.nvim_buf_set_extmark(bufnr, ns, i - 1, info.col_start, {
            end_col = info.col_end,
            hl_group = "FugitiveBlameAge" .. math.floor(t * STEPS + 0.5),
            priority = 200,
          })
        end
      end

      define_blame_age_highlights()
      vim.api.nvim_create_autocmd("ColorScheme", { callback = define_blame_age_highlights })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "fugitiveblame",
        callback = function(args)
          apply_blame_age(args.buf)
        end,
      })
    end

    -- Improve select line inside fugitive
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "fugitive", "git" },
      callback = function(args)
        vim.keymap.set("n", "<C-l>", function()
          local line = vim.api.nvim_get_current_line()
          if line:match("^Head: ") or line:match("^Rebase: ") or line:match("^Push: ") then
            vim.cmd("normal! _wwvg_") -- Select branch name
          elseif vim.bo[args.buf].filetype == "fugitive" then
            vim.cmd("normal! _wvg_") -- Skip status before file name
          elseif line:match("^[+-]") then
            vim.cmd("normal! _wvg_") -- Skip + or - character inside diff
          else
            vim.cmd("normal! _vg_")
          end
        end, { buffer = args.buf, desc = "Select line content inside fugitive/git buffer" })
      end,
    })

    vim.keymap.set("n", "<leader>grr", function()
      local branches = vim.api.nvim_exec2("!git -C \"%:h\" branch -r | grep -v 'HEAD' | grep -v 'main'",
      { output = true })
      if branches.output == nil then
        return print("No remote branch detected")
      else
        local branch_text, _ = branches.output:gsub(":!git[^\n]+", ""):gsub("%s+", " ")
        vim.cmd("silent !git -C \"%:h\" branch -d" .. branch_text .. " --remote")
      end
    end, { desc = "Git remove all remote branch tracking" })
  end,
}
