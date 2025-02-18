require("options")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local lazy = require("lazy")

if vim.g.vscode then
	require("keymaps-vscode")
else
	require("keymaps")
	lazy.setup({
		change_detection = {
			enabled = true,
			notify = false,
		},
		spec = {
			{ import = "plugins" },
			{ import = "plugins.debugging" },
			{ import = "plugins.editor" },
			{ import = "plugins.git" },
			{ import = "plugins.languages" },
			{ import = "plugins.lsp" },
			{ import = "plugins.theming" },
		},
	})
end

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highligh when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
