vim.g.mapleader = " "
vim.g.maplocalleader = " "
-- vim.opt.clipboard = "unnamedplus"
vim.cmd("language en_US")

vim.opt.swapfile = false;
vim.g.have_nerd_font = true
vim.opt.mouse = "a"
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.shadafile = "NONE"

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.showmode = true
-- vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes"
vim.opt.splitright = true
vim.opt.splitbelow = false



-- vim.opt.updatetime = 250
-- vim.opt.timeoutlen = 400

-- vim.opt.list = false
-- vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.sidescroll = 1
vim.opt.sidescrolloff = 10
vim.opt.hlsearch = true

require("config.lazy")
require("config.custom.zig-errors")

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking text",
  group = vim.api.nvim_create_augroup("kassu-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank({ timeout = 100 })
  end,
})

-- vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clean search" })
vim.keymap.set({ "n", "x" }, "<leader>w", "\"+", { desc = "Clipboard registry" })
vim.keymap.set({ "n", "x" }, "<leader>d", "\"_d", { desc = "Delete to void registry" })
vim.keymap.set("n", "<leader>D", "\"_D", { desc = "Delete to void registry" })
vim.keymap.set("x", "<leader>p", "\"_dP", { desc = "Paste and delete to void registry" });

vim.keymap.set("n", "<leader><leader>x", "<cmd>source %<CR>", { desc = "Source full file" });
vim.keymap.set("n", "<leader>x", ":.lua<CR>", { desc = "Source current line" });
vim.keymap.set("v", "<leader>x", ":lua<CR>", { desc = "Source visual selection" });
vim.keymap.set("n", "<leader><leader>q", ":set nowrap!<CR>", { desc = "Toggle wrap" });

vim.keymap.set("n", "<M-e>", vim.diagnostic.open_float, { desc = "Show diagnostic Error messages" })
vim.keymap.set("n", "€", vim.diagnostic.open_float, { desc = "Show diagnostic Error messages" })
-- vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic Quickfix list" })
vim.keymap.set("v", "(", "S(", { remap = true, desc = "Surround selection ( text )" });
vim.keymap.set("v", ")", "S)", { remap = true, desc = "Surround selection (text)" });
vim.keymap.set("v", "[", "S[", { remap = true, desc = "Surround selection [ text ]" });
vim.keymap.set("v", "]", "S]", { remap = true, desc = "Surround selection [text]" });
vim.keymap.set("v", "{", "S{", { remap = true, desc = "Surround selection { text }" });
vim.keymap.set("v", "}", "S}", { remap = true, desc = "Surround selection {text}" });

vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

vim.keymap.set("n", "<left>", "<cmd>echo \"Use h to move!!\"<CR>")
vim.keymap.set("n", "<right>", "<cmd>echo \"Use l to move!!\"<CR>")
vim.keymap.set("n", "<up>", "<cmd>echo \"Use k to move!!\"<CR>")
vim.keymap.set("n", "<down>", "<cmd>echo \"Use j to move!!\"<CR>")

vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "<S-n>", "Nzz")
vim.keymap.set("n", "<C-e>", "7<C-e>")
vim.keymap.set("n", "<C-y>", "7<C-y>")
vim.keymap.set("n", "<leader>.", "`.")
vim.keymap.set("n", "<leader>bo", ":%bd|e#<CR>")

vim.keymap.set("n", "ö", ":cprev<CR>zz")
vim.keymap.set("n", "ä", ":cnext<CR>zz")

vim.keymap.set("i", "<C-v>", "<C-o>:set paste<CR><C-r>+<C-o>:set nopaste<CR>", { desc = "Windows clipboard paste" })
vim.keymap.set("c", "<C-v>", "<C-r>+", { desc = "Windows clipboard paste" })
vim.keymap.set("i", "<C-g>", "<C-o>:set paste<CR><C-r>\"<C-o>:set nopaste<CR>", { desc = "Paste yank" })
-- vim.keymap.set("i", "<C-b>", "<C-o>\"_de", { desc = "Delete word forward" })
-- vim.keymap.set("i", "<C-l>", "<Del>", { desc = "Delete forward" })
-- vim.keymap.set("i", "<M-l>", "<right>", { desc = "Move caret right" })
-- vim.keymap.set("i", "<M-h>", "<left>", { desc = "Move caret left" })
-- vim.keymap.set("i", "<M-f>", "<C-right>", { desc = "Move caret one word right" })
-- vim.keymap.set("i", "<M-d>", "<C-left>", { desc = "Move caret one word left" })
-- vim.keymap.set("i", "<C-k>", "<CR><C-c>kddpkI<cmd>:let @\" = @0<CR>", { desc = "Line break above" });
-- vim.keymap.set("i", "<M-k>", "<C-o>O", { desc = "New line above" });
-- vim.keymap.set("i", "<M-j>", "<C-o>o", { desc = "New line below" });

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

vim.keymap.set("n", "<C-L>", "_v$h", { desc = "Select line" });
vim.keymap.set("v", "<C-L>", "o_oj$h", { desc = "Expand line selection" });
vim.keymap.set("n", "<leader>r", ":%s/\\<<C-r><C-w>\\>//g<Left><Left>")
vim.keymap.set("x", "<leader>r", "y:%s/\\V<C-r>\"//g<Left><Left>")

vim.keymap.set("n", ">", function() vim.cmd("normal! <<") end, { silent = true, desc = "Indent line" })
vim.keymap.set("x", ">", function() vim.cmd("normal! <gv") end, { silent = true, desc = "Indent line" })
vim.keymap.set("n", "<", function() vim.cmd("normal! >>") end, { silent = true, desc = "Indent selection" })
vim.keymap.set("x", "<", function() vim.cmd("normal! >gv") end, { silent = true, desc = "Indent selection" })


vim.keymap.set("n", "gp", function() vim.cmd("normal! `[v`]") end, { silent = true, desc = "Select pasted" })

vim.api.nvim_set_hl(0, "Visual", { bg = "#0398fc", fg = "#000000", })
vim.api.nvim_set_hl(0, "cursorline", { bg = "#15191d" })
vim.api.nvim_set_hl(0, "cursorlinenr", { bg = "#15191d", fg = "#e5ff00" })

vim.api.nvim_set_hl(0, "MatchParen", { fg = "#FF0000", bg = "NONE", undercurl = true })
vim.api.nvim_set_hl(0, "MatchParenCur", {}) -- This keeps the cursor color same

vim.api.nvim_set_hl(0, "Search", { bg = "#86af61", fg = "#000000" })
vim.api.nvim_set_hl(0, "CurSearch", { bg = "#fe5f60", fg = "#000000" })
vim.api.nvim_set_hl(0, "IncSearch", { bg = "#fe5f60", fg = "#000000" })

vim.api.nvim_set_hl(0, "MultiCursorCursor", { bg = "#97ca72", fg = "#000000" })
vim.api.nvim_set_hl(0, "MultiCursorVisual", { bg = "#0398fc", fg = "#000000" })
vim.api.nvim_set_hl(0, "MultiCursorDisabledCursor", { bg = "#97ca72", fg = "#000000" })
vim.api.nvim_set_hl(0, "MultiCursorDisabledVisual", { bg = "#0398fc", fg = "#000000" })
vim.api.nvim_set_hl(0, "MultiCursorSign", { link = "SignColumn" })
vim.api.nvim_set_hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })

vim.cmd [[hi @lsp.typemod.variable.readonly.javascript guifg=#abbeff]]
vim.cmd [[hi @lsp.type.namespace.zig guifg=#ef5f6b]]
vim.cmd [[hi @constructor gui=None]]

if vim.g.neovide then
  vim.g.neovide_hide_mouse_when_typing = true;
  vim.g.neovide_scroll_animation_length = 0
  vim.g.neovide_position_animation_length = 0

  vim.g.neovide_touch_drag_timeout = 0
  vim.g.neovide_cursor_animation_length = 0.05
  vim.g.neovide_cursor_trail_size = 0.2
  vim.g.neovide_background_image = "C:\\Users\\kaspe\\Desktop\\kuvat\\test\\cat\\cat.1501.jpg"
  vim.g.neovide_title_background_color = "#0b0b0b"
  vim.g.neovide_title_text_color = "#FFFFFF"

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
