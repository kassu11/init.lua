return {
  "ej-shafran/compile-mode.nvim",
  version = "^5.0.0",
  -- you can just use the latest version:
  -- branch = "latest",
  -- or the most up-to-date updates:
  -- branch = "nightly",
  dependencies = {
    "nvim-lua/plenary.nvim",
    -- if you want to enable coloring of ANSI escape codes in
    -- compilation output, add:
    -- { "m00qek/baleia.nvim", tag = "v1.3.0" },
  },
  config = function()
    ---@type CompileModeOpts
    vim.g.compile_mode = {
      default_command = {
        c = "gcc main.c",
      },
    }

    vim.keymap.set("n", "<leader>r", ":below Compile<CR>", { desc = "Start compile mode" })
    vim.keymap.set("n", "<leader>R", ":below Recompile<CR>", { desc = "Start compile mode" })
  end
}
