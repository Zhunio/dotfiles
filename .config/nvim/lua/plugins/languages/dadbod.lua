return {
	"kristijanhusak/vim-dadbod-ui",
	cmd = {
		"DBUI",
		"DBUIToggle",
		"DBUIAddConnection",
		"DBUIFindBuffer",
	},
	dependencies = {
		{ "tpope/vim-dadbod" },
		{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" } },
		{ "ellisonleao/dotenv.nvim", ft = { "sql", "mysql", "plsql" } },
		{ "hrsh7th/nvim-cmp" },
	},
	config = function() end,
	init = function()
		vim.g.db_ui_use_nerd_fonts = 1
		vim.g.db_ui_winwidth = 50

		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "sql", "mysql", "plsql" },
			callback = function()
				require("cmp").setup.buffer({ sources = { { name = "vim-dadbod-completion" } } })
			end,
		})

		require("dotenv").setup({
			enable_on_load = true, -- will load your .env file upon loading a buffer
			verbose = false, -- show error notification if .env file is not found and if .env is loaded
		})
	end,
}
