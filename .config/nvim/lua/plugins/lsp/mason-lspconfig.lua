return {
	{
		"williamboman/mason-lspconfig.nvim",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = { "neovim/nvim-lspconfig" },
		config = function()
			local servers = {
				"angularls",
				"bashls",
				"lua_ls",
				"terraformls",
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
