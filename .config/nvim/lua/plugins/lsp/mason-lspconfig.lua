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
				"terraformls",
        "ts_ls",
			}

			for _, server in ipairs(servers) do
				local server_config = require("config.lsp.servers." .. server)
				vim.lsp.config(server, server_config)
			end

			-- TODO: Update this so that it does not get called by mason-lspconfig, instead it gets called by jdtls
			-- ["jdtls"] = function() end,

			require("mason-lspconfig").setup({})
		end,
	},
}
