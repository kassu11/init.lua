vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.clipboard = "unnamedplus"
vim.cmd("language en_US")

vim.opt.swapfile = false;
vim.g.have_nerd_font = true
vim.opt.mouse = "a"

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.showmode = false
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes"

vim.opt.updatetime = 250
vim.opt.timeoutlen = 400
vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.hlsearch = true


require("config.lazy")

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<leader>w", "\"+", { desc = "Clipboard registry" })
vim.keymap.set("v", "<leader>w", "\"+", { desc = "Clipboard registry" })

vim.keymap.set("n", "<leader><leader>x", "<cmd>source %<CR>");
vim.keymap.set("n", "<leader>x", ":.lua<CR>");
vim.keymap.set("v", "<leader>x", ":lua<CR>");

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

vim.keymap.set("n", "<left>", "<cmd>echo \"Use h to move!!\"<CR>")
vim.keymap.set("n", "<right>", "<cmd>echo \"Use l to move!!\"<CR>")
vim.keymap.set("n", "<up>", "<cmd>echo \"Use k to move!!\"<CR>")
vim.keymap.set("n", "<down>", "<cmd>echo \"Use j to move!!\"<CR>")
vim.keymap.set("i", "<C-v>", "<cmd>:normal \"+p <CR>")

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking text",
  group = vim.api.nvim_create_augroup("kassu-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank({ timeout = 100 })
  end,
})


-- Remove bg
-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "Visual", { bg = "#0398fc", fg = "#000000", })
vim.api.nvim_set_hl(0, "cursorline", { bg = "#15191d" })
vim.api.nvim_set_hl(0, "cursorlinenr", { bg = "#15191d", fg = "#e5ff00" })
-- print(
--   vim.api.nvim_get_hl(0, {name = "cursorline"}).sp,
--   vim.api.nvim_get_hl(0, {name = "cursorline"}).bg,
--   vim.api.nvim_get_hl(0, {name = "cursorline"}).fg,
--   vim.api.nvim_get_hl(0, {name = "cursorline"}).reverse
-- )

-- vim.api.nvim_create_autocmd({"ColorScheme", "VimEnter"}, {
--     group = vim.api.nvim_create_augroup('Color', {}),
--     pattern = "*",
--     callback = function ()
--         vim.api.nvim_set_hl(0, "LspReferenceRead", {bg = "#1d2022"})
--         vim.api.nvim_set_hl(0, "LspReferenceWrite", {bg = "#1d2022"})
--         vim.api.nvim_set_hl(0, "LspReferenceText", {bg = "#1d2022"})
--     end
-- })
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

vim.keymap.set("n", "<leader>o", "<cmd>:!start . <CR>")
vim.keymap.set("x", "<leader>p", "\"_dP");
vim.keymap.set("n", "<C-S-L>", "_v$h");
vim.keymap.set("n", "<C-d>", "<C-d>zz");
vim.keymap.set("n", "<C-u>", "<C-u>zz");

if vim.g.neovide then
  vim.g.neovide_hide_mouse_when_typing = true;
  vim.g.neovide_scroll_animation_length = 0
  vim.g.neovide_position_animation_length = 0

  vim.g.neovide_touch_drag_timeout = 0
  vim.g.neovide_cursor_animation_length = 0.05
  vim.g.neovide_cursor_trail_size = 0.2
  vim.g.neovide_background_image = "C:\\Users\\kaspe\\Desktop\\kuvat\\test\\cat\\cat.1501.jpg"
  vim.o.guifont = "FiraCode Nerd Font Mono"
  vim.keymap.set({"n", "x", "i"}, "<F11>", function() vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen end)
end

