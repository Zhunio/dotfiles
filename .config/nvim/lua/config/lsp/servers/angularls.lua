local on_attach = require("config.lsp.on_attach")

return {
	on_attach = on_attach,
	root_dir = function(fname)
		local lspconfig = require("lspconfig")
		local root = lspconfig.util.root_pattern("angular.json", "workspace.json", "project.json")(fname)

		-- returning nil prevents the server from starting
		return root or nil
	end,
}
