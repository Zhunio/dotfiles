return {

	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
	},
	config = function()
		require("mason").setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		require("mason-lspconfig").setup({
			ensure_installed = { "lua_ls", "html", "cssls", "ts_ls", "angularls" },
			automatic_installation = true,
		})

		local on_attach = function()
			vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, {})
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, {})
			vim.keymap.set("n", "g=", vim.lsp.buf.code_action, {})
		end

		local lspConfig = require("lspconfig")
		lspConfig.lua_ls.setup({ on_attach = on_attach })
		lspConfig.html.setup({ on_attach = on_attach })
		lspConfig.cssls.setup({ on_attach = on_attach })
		lspConfig.ts_ls.setup({ on_attach = on_attach })
		lspConfig.angularls.setup({ on_attach = on_attach })

		-- Change the Diagnostic symbols in the sign column (gutter)
		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end
	end,
}
