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

    -- In a fugitive status buffer, open the fugitive status of the
    -- submodule under cursor. Reuses fugitive's own cursor-file resolution
    -- (the same one <CR> uses) to get the submodule's absolute path, then
    -- edits its "<submodule>/.git" gitlink file instead of the submodule
    -- directory itself -- that's a regular file that always exists, so it
    -- never triggers mini.files (works even for submodules with no files
    -- at top level) and it replaces the status buffer in place, so <C-o>
    -- jumps back to it.
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
