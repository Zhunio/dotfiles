local with_plugin = require("config.with-plugin")

return {
	require("plugins.shared.nvim-cmp"),
	require("plugins.shared.treesitter"),
	require("plugins.shared.octo"),
	with_plugin("plugins.shared.conform", {
		opts = {
			formatters_by_ft = {
				html = { "prettier" },
				css = { "prettier" },
				scss = { "prettier" },
			},
		},
	}),
	with_plugin("plugins.shared.mason-tool-installer", {
		opts = {
			ensure_installed = { "angularls", "emmet_language_server", "html", "cssls", "prettier" },
		},
	}),
	with_plugin("plugins.shared.mason-lspconfig", {
		config = function()
			local on_attach = require("config.on_attach")
			vim.lsp.config("angularls", vim.tbl_deep_extend("force", { on_attach = on_attach }, {
				root_dir = function(fname)
					local lspconfig = require("lspconfig")
					local root = lspconfig.util.root_pattern("angular.json", "workspace.json", "project.json")(fname)
					return root or nil
				end,
			}))
			vim.lsp.config("emmet_language_server", vim.tbl_deep_extend("force", { on_attach = on_attach }, {}))
			vim.lsp.config("html", vim.tbl_deep_extend("force", { on_attach = on_attach }, {
				filetypes = { "html" },
			}))

			require("mason-lspconfig").setup({})
		end,
	}),
}
