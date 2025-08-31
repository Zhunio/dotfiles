-- Bootstrap lazy.nvim
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

if vim.g.vscode then
	require("config.keymaps-vscode")
else
	require("config.keymaps")
	require("lazy").setup({
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
			{ import = "plugins.testing" },
			{ import = "plugins.theming" },
		},
	})
end
