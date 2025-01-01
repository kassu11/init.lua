return {
  {
    'nvim-telescope/telescope-project.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim' },
    config = function()
      require 'telescope'.load_extension('project')
      vim.keymap.set("n", "<leader>sp", function() vim.cmd("Telescope project") end)
    end,
  }
}
