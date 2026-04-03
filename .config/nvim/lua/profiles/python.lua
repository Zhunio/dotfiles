return {
	require("plugins.shared.nvim-cmp"),
	require("plugins.shared.treesitter"),
	vim.tbl_deep_extend("force", require("plugins.shared.conform"), {
		opts = {
			formatters_by_ft = {
				python = { "black" },
			},
		},
	}),
	vim.tbl_deep_extend("force", require("plugins.shared.mason-tool-installer"), {
		opts = {
			ensure_installed = { "pyright", "black", "isort" },
		},
	}),
	vim.tbl_deep_extend("force", require("plugins.shared.mason-lspconfig"), {
		config = function()
			local on_attach = require("plugins.shared.on-attach")
			vim.lsp.config("pyright", vim.tbl_deep_extend("force", { on_attach = on_attach }, {}))

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
