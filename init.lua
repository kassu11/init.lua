vim.g.mapleader = " "
vim.g.maplocalleader = " "
-- vim.opt.clipboard = "unnamedplus"
vim.cmd("language en_US")

vim.opt.swapfile = false;
vim.g.have_nerd_font = true
vim.opt.mouse = "a"
vim.opt.expandtab = true
vim.opt.shiftwidth = 2

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.showmode = false
-- vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes"

-- vim.opt.updatetime = 250
-- vim.opt.timeoutlen = 400
-- vim.opt.splitright = true
-- vim.opt.splitbelow = true

-- vim.opt.list = false
-- vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.hlsearch = true

require("config.lazy")

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking text",
  group = vim.api.nvim_create_augroup("kassu-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank({ timeout = 100 })
  end,
})

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clean search" })
vim.keymap.set("n", "<leader>w", "\"+", { desc = "Clipboard registry" })
vim.keymap.set("v", "<leader>w", "\"+", { desc = "Clipboard registry" })

vim.keymap.set("n", "<leader><leader>x", "<cmd>source %<CR>", { desc = "Source full file" });
vim.keymap.set("n", "<leader>x", ":.lua<CR>", { desc = "Source current line" });
vim.keymap.set("v", "<leader>x", ":lua<CR>", { desc = "Source visual selection" });
vim.keymap.set("n", "<leader><leader>q", ":set nowrap!<CR>", { desc = "Toggle wrap" });

-- vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic Error messages" })
-- vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic Quickfix list" })

vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

vim.keymap.set("n", "<left>", "<cmd>echo \"Use h to move!!\"<CR>")
vim.keymap.set("n", "<right>", "<cmd>echo \"Use l to move!!\"<CR>")
vim.keymap.set("n", "<up>", "<cmd>echo \"Use k to move!!\"<CR>")
vim.keymap.set("n", "<down>", "<cmd>echo \"Use j to move!!\"<CR>")

vim.keymap.set("i", "<C-v>", "<C-o>:set paste<CR><C-r>+<C-o>:set nopaste<CR>", { desc = "Windows clipboard paste" })
vim.keymap.set("i", "<C-g>", "<C-o>:set paste<CR><C-r>\"<C-o>:set nopaste<CR>", { desc = "Paste yank" })
vim.keymap.set("i", "<C-b>", "<C-o>\"_de", { desc = "Delete word forward" })
vim.keymap.set("i", "<C-l>", "<Del>", { desc = "Delete forward" })
vim.keymap.set("i", "<M-l>", "<right>", { desc = "Move caret right" })
vim.keymap.set("i", "<M-h>", "<left>", { desc = "Move caret left" })
vim.keymap.set("i", "<M-f>", "<C-right>", { desc = "Move caret one word right" })
vim.keymap.set("i", "<M-d>", "<C-left>", { desc = "Move caret one word left" })
vim.keymap.set("i", "<C-k>", "<CR><C-c>kddpkI<cmd>:let @\" = @0<CR>", { desc = "Line break above" });
vim.keymap.set("i", "<M-k>", "<C-o>O", { desc = "New line above" });
vim.keymap.set("i", "<M-j>", "<C-o>o", { desc = "New line below" });

vim.keymap.set("n", "<leader>o", "<cmd>:!start . <CR>", { desc = "Open working directory" })
vim.keymap.set("x", "<leader>p", "\"_dP", { desc = "Paste and delete to void registry" });
vim.keymap.set("x", "<leader>d", "\"_d", { desc = "Delete to void registry" });
vim.keymap.set("n", "<C-L>", "_v$h", { desc = "Select line" });
vim.keymap.set("v", "<C-L>", "o_oj$h", { desc = "Expand line selection" });
vim.keymap.set("n", "<leader>r", ":%s/\\<<C-r><C-w>\\>//g<Left><Left>")
vim.keymap.set("x", "<leader>r", "y:%s/\\V<C-r>\"//g<Left><Left>")

vim.keymap.set("n", "<", function() vim.cmd("normal! <<") end, { silent = true, desc = "Indent line" })
vim.keymap.set("x", "<", function() vim.cmd("normal! <gv") end, { silent = true, desc = "Indent line" })
vim.keymap.set("n", ">", function() vim.cmd("normal! >>") end, { silent = true, desc = "Indent selection" })
vim.keymap.set("x", ">", function() vim.cmd("normal! >gv") end, { silent = true, desc = "Indent selection" })

vim.keymap.set("n", "gp", function() vim.cmd("normal! `[v`]") end, { silent = true, desc = "Select pasted" })




vim.api.nvim_set_hl(0, "Visual", { bg = "#0398fc", fg = "#000000", })
vim.api.nvim_set_hl(0, "cursorline", { bg = "#15191d" })
vim.api.nvim_set_hl(0, "cursorlinenr", { bg = "#15191d", fg = "#e5ff00" })

vim.cmd [[hi @lsp.typemod.variable.readonly.javascript guifg=#abbeff]]

if vim.g.neovide then
  vim.g.neovide_hide_mouse_when_typing = true;
  vim.g.neovide_scroll_animation_length = 0
  vim.g.neovide_position_animation_length = 0

  vim.g.neovide_touch_drag_timeout = 0
  vim.g.neovide_cursor_animation_length = 0.05
  vim.g.neovide_cursor_trail_size = 0.2
  vim.g.neovide_background_image = "C:\\Users\\kaspe\\Desktop\\kuvat\\test\\cat\\cat.1501.jpg"
  vim.g.neovide_font_features = {
    ["FiraCode Nerd Font Mono"] = {
      '-calt',
    }
  }
  vim.o.guifont = "FiraCode Nerd Font Mono"
  vim.keymap.set({ "n", "x", "i" }, "<F11>", function() vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen end,
    { desc = "Enter fullscreen" })
  vim.keymap.set("n", "<C-0>",
    ":lua vim.g.neovide_scale_factor = 1<CR>", { silent = true })
  vim.keymap.set("n", "<C-->",
    ":lua vim.g.neovide_scale_factor = math.max(vim.g.neovide_scale_factor - 0.1,  0.1)<CR>", { silent = true })
  vim.keymap.set("n", "<C-+>",
    ":lua vim.g.neovide_scale_factor = math.min(vim.g.neovide_scale_factor + 0.1,  5)<CR>", { silent = true })
end


-- Diagnostic keymaps
-- vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
-- vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })

-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

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
