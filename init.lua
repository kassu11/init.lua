vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.signcolumn = "yes:1"
vim.opt.winborder = "rounded"
vim.opt.shadafile = "NONE"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.list = true
vim.opt.splitright = true
vim.opt.listchars = { tab = "» ", trail = "·" }

require("config.lazy")

vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
vim.keymap.set({ "n", "x" }, "<leader>w", "\"+", { desc = "Global registry" })

vim.keymap.set("n", "<C-L>", "_v$h", { desc = "Select line" });
vim.keymap.set("v", "<C-L>", "o_oj$h", { desc = "Expand line selection" });
vim.keymap.set("n", "<leader>r", ":%s/\\<<C-r><C-w>\\>//g<Left><Left>", { desc = "Search and replace" })
vim.keymap.set("x", "<leader>r", "y:%s/\\V<C-r>\"//g<Left><Left>", { desc = "Search and replace" })

vim.keymap.set("n", "gp", function() vim.cmd "normal! `[v`]" end, { silent = true, desc = "Select pasted" })

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clean search" })

vim.keymap.set("n", "y_", "y^", { desc = "Yank to line start" })
vim.keymap.set("n", "c_", "c^", { desc = "Delete and insert to line start" })
vim.keymap.set("n", "d_", "d^", { desc = "Delete to line start" })

vim.keymap.set("n", "<leader>.", "`.", { desc = "Jump to where last edited" })
vim.keymap.set("n", "<leader>bo", ":%bd|e#<CR>", { desc = "Close saved buffers" });
vim.keymap.set("n", "<leader>t", function()
  vim.cmd 'windo execute "normal! \\<C-^>"'
end, { desc = "Jump to previous buffer on all windows" });

vim.keymap.set("n", "ö", ":cprev<CR>zz", { desc = "Previous quick fix list" })
vim.keymap.set("n", "ä", ":cnext<CR>zz", { desc = "Next quick fix list" })

vim.keymap.set({ "n", "x" }, "<leader>d", "\"_d", { desc = "Delete to void registry" })
vim.keymap.set({ "n", "x" }, "<leader>c", "\"_c", { desc = "Insert delete to void registry" })

vim.keymap.set("n", "<leader>o", function()
  local path = vim.fn.getcwd();
  vim.cmd("silent !start /I cmd /K \"cd /d " .. path .. "\"")
end, { desc = "Open cmd to cwd" })

vim.keymap.set("n", "<leader>O", function()
  local path = vim.fn.expand('%:p:h')
  vim.cmd("silent !start /I cmd /K \"cd /d " .. path .. "\"")
end, { desc = "Open cmd to buff path" })

vim.keymap.set("n", "<leader>e", function()
  local path = vim.fn.getcwd();
  vim.cmd("silent !start explorer " .. path)
end, { desc = "Open working directory" })

vim.keymap.set("n", "<leader>E", function()
  local path = vim.fn.expand('%:p')
  vim.cmd("silent !start explorer /select," .. path)
end, { desc = "Open current buff directory" })




vim.keymap.set("n", "<left>", "<cmd>echo \"Use h to move!!\"<CR>")
vim.keymap.set("n", "<right>", "<cmd>echo \"Use l to move!!\"<CR>")
vim.keymap.set("n", "<up>", "<cmd>echo \"Use k to move!!\"<CR>")
vim.keymap.set("n", "<down>", "<cmd>echo \"Use j to move!!\"<CR>")

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking text",
  group = vim.api.nvim_create_augroup("custom-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank({ timeout = 50 })
  end,
})

vim.cmd "language en_US"

vim.cmd "colorscheme vague"
vim.cmd ":hi statusline guibg=NONE"
