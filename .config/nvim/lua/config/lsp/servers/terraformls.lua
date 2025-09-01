local on_attach = require("config.lsp.on_attach")

return {
	on_attach = on_attach,
	cmd = { "terraform-ls", "serve" },
	filetypes = { "terraform", "terraform-vars" },
}
