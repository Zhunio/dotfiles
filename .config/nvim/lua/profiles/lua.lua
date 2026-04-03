local with_plugin = require("config.with-plugin")

return {
	require("plugins.shared.nvim-cmp"),
	require("plugins.shared.treesitter"),
	with_plugin("plugins.shared.conform", {
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
			},
		},
	}),
	with_plugin("plugins.shared.mason-tool-installer", {
		opts = {
			ensure_installed = { "lua_ls", "stylua" },
		},
	}),
	with_plugin("plugins.shared.mason-lspconfig", {
		config = function()
			local on_attach = require("config.on_attach")
			vim.lsp.config("lua_ls", vim.tbl_deep_extend("force", { on_attach = on_attach }, {
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
						workspace = {
							checkThirdParty = false,
							library = vim.api.nvim_get_runtime_file("", true),
						},
					},
				},
			}))

			require("mason-lspconfig").setup({})
		end,
	}),
}
