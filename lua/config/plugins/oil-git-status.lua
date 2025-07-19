return {
  {
    "refractalize/oil-git-status.nvim",
    dependencies = {
      "stevearc/oil.nvim",
    },
    config = true,
  },
}

-- Switched the priority order in the library code to make status work with one column
-- if status_codes then
--   vim.api.nvim_buf_set_extmark(buffer, namespace, n - 1, 0, {
--     sign_text = get_symbol(current_config.symbols.index, status_codes.index),
--     sign_hl_group = highlight_group(status_codes.index, true),
--     priority = 1,
--   })
--   vim.api.nvim_buf_set_extmark(buffer, namespace, n - 1, 0, {
--     sign_text = get_symbol(current_config.symbols.working_tree, status_codes.working_tree),
--     sign_hl_group = highlight_group(status_codes.working_tree, false),
--     priority = 2,
--   })
-- end
