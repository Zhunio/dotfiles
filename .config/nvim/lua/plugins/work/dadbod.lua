return {
	"kristijanhusak/vim-dadbod-ui",
	cmd = {
		"DBUI",
		"DBUIToggle",
		"DBUIAddConnection",
		"DBUIFindBuffer",
	},
	dependencies = {
		{ "tpope/vim-dadbod", lazy = true },
		{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
		{ "hrsh7th/nvim-cmp", lazy = true },
	},
	config = function() end,
	init = function()
		vim.g.db_ui_use_nerd_fonts = 1
		vim.g.db_ui_winwidth = 50
		vim.g.db_ui_show_database_icon = 1

		vim.g.db_ui_save_location = vim.fn.expand("~/.local/share/dadbod_ui/queries/")
		vim.g.db_ui_tmp_query_location = vim.fn.expand("~/.local/share/dadbod_ui/tmp_queries/")

		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "sql", "mysql", "plsql" },
			callback = function()
				require("cmp").setup.buffer({ sources = { { name = "vim-dadbod-completion" } } })
			end,
		})
	end,
}
