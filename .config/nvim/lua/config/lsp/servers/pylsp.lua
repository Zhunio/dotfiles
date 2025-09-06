local on_attach = require("config.lsp.on_attach")

return {
	on_attach = on_attach,
	settings = {
		pylsp = {
			plugins = {},
		},
	},
}
