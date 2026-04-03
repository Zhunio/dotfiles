local with_plugin = require("config.with-plugin")

return {
	require("plugins.shared.nvim-cmp"),
	require("plugins.shared.treesitter"),
	require("plugins.shared.octo"),
	with_plugin("plugins.shared.conform", {
		opts = {
			formatters_by_ft = {
				javascript = { "prettier" },
				typescript = { "prettier" },
				json = { "prettier" },
				yaml = { "prettier" },
				markdown = { "prettier" },
			},
		},
	}),
	with_plugin("plugins.shared.mason-tool-installer", {
		opts = {
			ensure_installed = { "ts_ls", "js-debug-adapter", "prettier" },
		},
	}),
	with_plugin("plugins.shared.mason-lspconfig", {
		config = function()
			local on_attach = require("config.on_attach")
			vim.lsp.config("ts_ls", vim.tbl_deep_extend("force", { on_attach = on_attach }, {
				cmd = { "typescript-language-server", "--stdio" },
				on_attach = function(_, bufnr)
					on_attach(_, bufnr)
					vim.keymap.set("n", "gO", function()
						vim.lsp.buf.execute_command({
							command = "_typescript.organizeImports",
							arguments = { vim.api.nvim_buf_get_name(bufnr) },
						})
					end, { buffer = bufnr, desc = "LSP: Organize Imports" })
				end,
				filetypes = {
					"javascript",
					"javascriptreact",
					"javascript.jsx",
					"typescript",
					"typescriptreact",
					"typescript.tsx",
				},
			}))

			require("mason-lspconfig").setup({})
		end,
	}),
}
