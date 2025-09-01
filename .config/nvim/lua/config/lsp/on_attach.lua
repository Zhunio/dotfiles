return function()
	vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, {})
	vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
end
