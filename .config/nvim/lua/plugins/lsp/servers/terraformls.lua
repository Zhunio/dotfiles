local on_attach = require("plugins.lsp.servers.on_attach")

return {
	on_attach = on_attach,
	cmd = { "terraform-ls", "serve" },
	filetypes = { "terraform", "terraform-vars" },
}
