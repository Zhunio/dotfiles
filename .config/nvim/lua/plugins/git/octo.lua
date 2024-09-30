return {
	{
		"pwntester/octo.nvim",
		keys = {
			{ "<leader>o", ":Octo pr list<CR>" },
		},
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("octo").setup()
		end,
	},
}
