local with_plugin = require("config.with-plugin")

return {
	require("plugins.shared.nvim-cmp"),
	require("plugins.shared.treesitter"),
	with_plugin("plugins.shared.conform", {
		opts = {
			formatters_by_ft = {
				python = { "black" },
			},
		},
	}),
	with_plugin("plugins.shared.mason-tool-installer", {
		opts = {
			ensure_installed = { "pyright", "black", "isort" },
		},
	}),
	with_plugin("plugins.shared.mason-lspconfig", {
		config = function()
			local on_attach = require("config.on_attach")
			vim.lsp.config("pyright", vim.tbl_deep_extend("force", { on_attach = on_attach }, {}))

			require("mason-lspconfig").setup({})
		end,
	}),
}
