return {
	{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" } },
	{
		"kristijanhusak/vim-dadbod-ui",
		cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
		keys = {
			{ "<leader>dd", ":DBUIToggle<CR>", desc = "DBUI Toggle" },
		},
		dependencies = { "tpope/vim-dadbod" },
		init = function()
			vim.g.db_ui_use_nerd_fonts = 1
		end,
	},
}
