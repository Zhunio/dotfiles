local on_attach = require("plugins.lsp.servers.on_attach")

return {
	cmd = { "bash-language-server", "start" },
	on_attach = on_attach,
	filetypes = { "sh", "bash", "zsh" },
}
