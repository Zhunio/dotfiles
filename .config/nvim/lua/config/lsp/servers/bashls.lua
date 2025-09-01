local on_attach = require("config.lsp.on_attach")

return {
	cmd = { "bash-language-server", "start" },
	on_attach = on_attach,
	filetypes = { "sh", "bash", "zsh" },
}
