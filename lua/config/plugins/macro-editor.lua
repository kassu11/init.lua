-- Edit a macro register in a floating scratch buffer.
--
-- <leader>q then a register key (e.g. <leader>qa) opens a small floating
-- window containing the macro stored in that register, rendered as
-- human-readable key notation (via keytrans()) instead of raw bytes.
-- This avoids the classic paste-then-yank corruption of macros that
-- contain special keys like <Esc>, <C-x>, arrow keys, etc: pasting a
-- register into a buffer and yanking it back is lossy because Neovim has
-- to display special/control bytes as stand-in glyphs, and re-yanking
-- captures those glyphs literally instead of the original keycodes.
--
-- Edit the notation as text (e.g. write `<Esc>` literally to mean the
-- Escape key), then :w / :wq / :x to write it back into the register,
-- converted back to real keycodes via nvim_replace_termcodes(). :q or
-- <Esc> without writing discards the edit.

return {
  dir = vim.fn.stdpath("config"),
  name = "macro-editor",
  lazy = false,
  config = function()
    local function open_editor(regname)
      if vim.fn.exists("*keytrans") == 0 then
        vim.notify("macro-editor requires Neovim 0.9+ (keytrans())", vim.log.levels.ERROR)
        return
      end

      local regtype = vim.fn.getregtype(regname)
      local raw = vim.fn.getreg(regname, 1)
      local display = vim.fn.keytrans(raw)

      local buf = vim.api.nvim_create_buf(false, true)
      vim.api.nvim_buf_set_lines(buf, 0, -1, false, { display })
      vim.bo[buf].buftype = "acwrite"
      vim.bo[buf].bufhidden = "wipe"
      vim.bo[buf].swapfile = false
      pcall(vim.api.nvim_buf_set_name, buf, "macro://" .. regname)

      local width = math.max(20, math.min(#display + 4, vim.o.columns - 4))
      local height = 1
      local win = vim.api.nvim_open_win(buf, true, {
        relative = "editor",
        style = "minimal",
        border = "rounded",
        width = width,
        height = height,
        row = math.floor((vim.o.lines - height) / 2),
        col = math.floor((vim.o.columns - width) / 2),
        title = " macro @" .. regname .. " ",
        title_pos = "center",
      })
      vim.wo[win].wrap = true

      vim.api.nvim_create_autocmd("BufWriteCmd", {
        buffer = buf,
        callback = function()
          local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
          local text = table.concat(lines, "")
          local keys = vim.api.nvim_replace_termcodes(text, true, true, true)
          vim.fn.setreg(regname, keys, regtype)
          vim.bo[buf].modified = false
          vim.notify(("Updated macro @%s"):format(regname), vim.log.levels.INFO)
        end,
      })

      vim.keymap.set("n", "<Esc>", "<cmd>close<CR>", { buffer = buf, nowait = true, desc = "Discard macro edit" })
    end

    vim.keymap.set("n", "<leader>q", function()
      local ok, ch = pcall(vim.fn.getcharstr)
      if not ok or ch == "\27" then return end -- aborted with <Esc>
      open_editor(ch)
    end, { desc = "Edit macro register" })
  end,
}
