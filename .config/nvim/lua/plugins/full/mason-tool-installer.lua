local lsp = require("lsp")

return {
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	opts = function()
		return { ensure_installed = lsp.ensure_installed() }
	end,
}
