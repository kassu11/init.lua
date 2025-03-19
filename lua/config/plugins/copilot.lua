return {
  {
    "https://github.com/github/copilot.vim",
    config = function()
      local toggle_copilot = function()
        if vim.g.copilot_enabled ~= 0 then
          vim.cmd("Copilot disable")
        else
          vim.cmd("Copilot enable")
        end
      end

      vim.cmd("Copilot disable")
      vim.keymap.set("i", "<M-å>'", toggle_copilot)
    end,
  }
}
