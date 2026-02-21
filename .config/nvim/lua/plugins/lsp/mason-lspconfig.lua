return {
	{ "mfussenegger/nvim-jdtls", ft = { "java" } },
	{
		"williamboman/mason-lspconfig.nvim",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = { "neovim/nvim-lspconfig" },
		config = function()
			local servers = {
				"angularls",
				"bashls",
				"emmet_language_server",
				-- "gopls",
				"html",
				"jdtls",
				"lua_ls",
				"pylsp",
				-- "sqlls",
				"terraformls",
				"ts_ls",
				"vue_ls",
			}

			for _, server in ipairs(servers) do
				local server_config = require("config.lsp.servers." .. server)
				vim.lsp.config(server, server_config)
			end

			-- Change the Diagnostic symbols in the sign column (gutter)
			local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
			end

			vim.diagnostic.config({
				virtual_text = true,
			})

			-- TODO: Update this so that it does not get called by mason-lspconfig, instead it gets called by jdtls
			-- ["jdtls"] = function() end,

			require("mason-lspconfig").setup({})
		end,
	},
}
