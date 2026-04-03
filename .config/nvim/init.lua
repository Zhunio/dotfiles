-- Options
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.clipboard = "unnamedplus"
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.autoread = true
vim.opt.cursorline = true
vim.opt.relativenumber = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

local spec = { { import = "plugins.core" } }

require("config.profile").extend_core_plugins(spec, vim.fn.getcwd())

require("lazy").setup({
	lockfile = vim.fn.stdpath("data") .. "/lazy-lock.json",
	change_detection = {
		enabled = true,
		notify = false,
	},
	spec = spec,
})

-- Keymaps
vim.keymap.set("i", "jj", "<Esc>")
vim.keymap.set("i", "jk", "<Esc>")

vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save file" })
vim.keymap.set("n", "<leader>R", ":checktime<CR>", { desc = "Reload file changed outside Neovim" })

vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

vim.keymap.set("v", "J", ":move .+1<CR>==")
vim.keymap.set("v", "K", ":move .-1<CR>==")
vim.keymap.set("x", "J", ":move '>+1<CR>gv-gv")
vim.keymap.set("x", "K", ":move '<-2<CR>gv-gv")

vim.keymap.set("n", "<leader>ss", ":split<CR>", { desc = "Horizontal Split" })
vim.keymap.set("n", "<leader>sv", ":vsplit<CR>", { desc = "Vertical Split" })

vim.keymap.set("n", "<C-right>", ":vertical resize +2<CR>", { desc = "Vertical Resize +" })
vim.keymap.set("n", "<C-down>", ":resize +2<CR>", { desc = "Horizontal Resize +" })
vim.keymap.set("n", "<C-left>", ":vertical resize -2<CR>", { desc = "Vertical Resize -" })
vim.keymap.set("n", "<C-up>", ":resize -2<CR>", { desc = "Horizontal Resize -" })

vim.keymap.set("v", "p", '"_dP')
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Autocommands
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
