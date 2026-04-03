return {
	require("plugins.shared.nvim-cmp"),
	require("plugins.shared.treesitter"),
	vim.tbl_deep_extend("force", require("plugins.shared.conform"), {
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
			},
		},
	}),
	vim.tbl_deep_extend("force", require("plugins.shared.mason-tool-installer"), {
		opts = {
			ensure_installed = { "lua_ls", "stylua" },
		},
	}),
	vim.tbl_deep_extend("force", require("plugins.shared.mason-lspconfig"), {
		config = function()
			local on_attach = require("plugins.shared.on-attach")
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
