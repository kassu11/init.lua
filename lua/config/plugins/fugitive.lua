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
