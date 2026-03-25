local on_attach = require("plugins.work.lsp.servers.on_attach")

return {
	on_attach = on_attach,
	settings = {
		Lua = {
			workspace = {
				library = { vim.env.VIMRUNTIME },
			},
			diagnostics = {
				globals = { "vim" },
			},
			completion = {
				callSnippet = "Replace",
			},
		},
	},
}
