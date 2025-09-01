if vim.g.vscode then
	require("core.keymaps.keymaps-vscode")
else
	require("core.keymaps.keymaps")
end
