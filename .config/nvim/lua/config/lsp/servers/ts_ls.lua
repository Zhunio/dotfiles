local on_attach = require("config.lsp.on_attach")

return {
	cmd = { "typescript-language-server", "--stdio" },
	on_attach = on_attach,
	filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
}
