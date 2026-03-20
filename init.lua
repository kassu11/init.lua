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

-- vim.pack.add {
-- 	{ src = "https://github.com/nvim-mini/mini.pick" },
-- 	{ src = "https://github.com/nvim-mini/mini.extra" },
-- 	{ src = "https://github.com/saghen/blink.cmp",                     version = "v1" },
-- 	{ src = "https://github.com/tpope/vim-fugitive" },
-- 	{ src = "https://github.com/mason-org/mason.nvim" },
-- 	{ src = "https://github.com/neovim/nvim-lspconfig" },
-- 	{ src = "https://github.com/nvim-lua/plenary.nvim" }, -- Harpoo and telescope uses plenary
-- 	{ src = "https://github.com/ThePrimeagen/harpoon",                 version = "harpoon2" },
-- 	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
-- 	{ src = "https://github.com/nvim-telescope/telescope-project.nvim" },
-- 	{ src = "https://github.com/kylechui/nvim-surround" },
-- 	{ src = "https://github.com/booperlv/nvim-gomove" },
-- }

-- require "telescope".load_extension "project"
-- require "multicursor-nvim".setup {}
-- require "mini.pick".setup {}
-- require "mini.extra".setup {}
-- require "mason".setup {}
-- require "vague".setup { italic = false }
--
-- vim.keymap.set("n", "<M-h>", "<Plug>GoNSMLeft", { desc = "Move char left" })
-- vim.keymap.set("n", "<M-j>", "<Plug>GoNSMDown", { desc = "Move line down" })
-- vim.keymap.set("n", "<M-k>", "<Plug>GoNSMUp", { desc = "Move line up" })
-- vim.keymap.set("n", "<M-l>", "<Plug>GoNSMRight", { desc = "Move char right" })
--
-- vim.keymap.set("x", "<M-h>", "<Plug>GoVSMLeft", { desc = "Move selection left" })
-- vim.keymap.set("x", "<M-j>", "<Plug>GoVSMDown", { desc = "Move selection down" })
-- vim.keymap.set("x", "<M-k>", "<Plug>GoVSMUp", { desc = "Move selection up" })
-- vim.keymap.set("x", "<M-l>", "<Plug>GoVSMRight", { desc = "Move selection right" })
--
-- vim.keymap.set("n", "<M-S-h>", "<Plug>GoNSDLeft", { desc = "Duplicate selection left" })
-- vim.keymap.set("n", "<M-S-j>", "<Plug>GoNSDDown", { desc = "Duplicate line down" })
-- vim.keymap.set("n", "<M-S-k>", "<Plug>GoNSDUp", { desc = "Duplicate line up" })
-- vim.keymap.set("n", "<M-S-l>", "<Plug>GoNSDRight", { desc = "Duplicate selection right" })
--
-- vim.keymap.set("x", "<M-S-h>", "<Plug>GoVSDLeft", { desc = "Duplicate selection left" })
-- vim.keymap.set("x", "<M-S-j>", "<Plug>GoVSDDown", { desc = "Duplicate selection down" })
-- vim.keymap.set("x", "<M-S-k>", "<Plug>GoVSDUp", { desc = "Duplicate selection up" })
-- vim.keymap.set("x", "<M-S-l>", "<Plug>GoVSDRight", { desc = "Duplicate selection right" })
--
-- local harpoon = require("harpoon")
--
-- harpoon:setup()
--
-- vim.keymap.set("n", "<leader>A", function()
-- 	harpoon.ui:toggle_quick_menu(harpoon:list())
-- end, { desc = "Harpoon open picker" })
--
-- local keys = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 0 };
--
-- for i = 1, #keys, 1 do
-- 	vim.keymap.set("n", "<leader>" .. keys[i], function() harpoon:list():select(i) end,
-- 		{ desc = "Harpoon select file " .. i })
-- 	vim.keymap.set("n", "<leader>h" .. keys[i], function() harpoon:list():replace_at(i) end,
-- 		{ desc = "Harpoon replace file " .. i })
-- end
--
--
-- require "oil".setup {
-- 	view_options = {
-- 		case_insensitive = true,
-- 		is_always_hidden = function(name, _)
-- 			return name == "..";
-- 		end,
-- 	}
-- }
--
-- vim.lsp.enable { "lua_ls", "clangd", "astro" }
-- vim.lsp.config("lua_ls", {
-- 	settings = {
-- 		Lua = {
-- 			workspace = {
-- 				library = vim.api.nvim_get_runtime_file("", true)
-- 			}
-- 		}
-- 	}
-- })
--
-- require "blink.cmp".setup {
-- 	completion = { menu = { auto_show = false } },
-- 	fuzzy = { implementation = "lua" },
-- 	keymap = {
-- 		["<M-å> 01"] = { "show", "show_documentation", "hide_documentation" }, -- Ctrl+space
-- 	},
-- }
--
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
vim.keymap.set({ "n", "x" }, "<leader>w", "\"+", { desc = "Global registry" })

vim.keymap.set("n", "<C-L>", "_v$h", { desc = "Select line" });
vim.keymap.set("v", "<C-L>", "o_oj$h", { desc = "Expand line selection" });

-- vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { desc = "Format file" })
-- vim.keymap.set("n", "<leader>sh", ":Pick help<CR>", { desc = "Search help" })
-- vim.keymap.set("n", "<leader>sf", ":Pick files<CR>", { desc = "Search files" })
--
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clean search" })

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

-- vim.keymap.set("n", "<C-k>", vim.diagnostic.open_float, { desc = "Open diagnostic" })
-- vim.keymap.set("n", "gd", require("telescope.builtin").lsp_definitions, { desc = "Goto Definition" })
-- vim.keymap.set("n", "grr", require("telescope.builtin").lsp_references, { desc = "Goto References" })
-- vim.keymap.set("n", "gri", require("telescope.builtin").lsp_implementations, { desc = "Goto Implementation" })
-- vim.keymap.set("n", "grt", require("telescope.builtin").lsp_type_definitions, { desc = "Type Definition" })
-- vim.keymap.set("n", "gO", require("telescope.builtin").lsp_document_symbols, { desc = "Document Symbols" })
-- vim.keymap.set("n", "grw", require("telescope.builtin").lsp_dynamic_workspace_symbols, { desc = "Workspace Symbols" })
-- vim.keymap.set("n", "grd", vim.lsp.buf.declaration, { desc = "Goto Declaration" })
-- vim.keymap.set({ "n", "x" }, "gra", vim.lsp.buf.code_action, { desc = "Code Action" })
-- vim.keymap.set("n", "ge", function() vim.diagnostic.jump { count = 1, float = true } end,
-- 	{ desc = "Goto next error message" })
-- vim.keymap.set("n", "gE", function() vim.diagnostic.jump { count = -1, float = true } end,
-- 	{ desc = "Goto previous error message" })

vim.cmd "language en_US"

vim.cmd "colorscheme vague"
vim.cmd ":hi statusline guibg=NONE"

