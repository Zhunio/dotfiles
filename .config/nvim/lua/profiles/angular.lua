return {
	require("plugins.shared.nvim-cmp"),
	require("plugins.shared.treesitter"),
	vim.tbl_deep_extend("force", require("plugins.shared.conform"), {
		opts = {
			formatters_by_ft = {
				html = { "prettier" },
				css = { "prettier" },
				scss = { "prettier" },
			},
		},
	}),
	vim.tbl_deep_extend("force", require("plugins.shared.mason-tool-installer"), {
		opts = {
			ensure_installed = { "angularls", "emmet_language_server", "html", "cssls", "prettier" },
		},
	}),
	vim.tbl_deep_extend("force", require("plugins.shared.mason-lspconfig"), {
		config = function()
			local on_attach = require("plugins.shared.on-attach")
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

			local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
			end

			vim.diagnostic.config({ virtual_text = true })
			require("mason-lspconfig").setup({})
		end,
	}),
}
