local on_attach = require("config.lsp.on_attach")

return {
	cmd = { "typescript-language-server", "--stdio" },
	on_attach = function(client, bufnr)
		on_attach()

		vim.keymap.set("n", "gO", function()
			vim.lsp.buf.execute_command({
				command = "_typescript.organizeImports",
				arguments = { vim.api.nvim_buf_get_name(bufnr) },
			})
		end, { desc = "LSP: Organize Imports" })
	end,
	filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
}
