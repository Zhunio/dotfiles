return {
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup({
				toggler = { line = "<leader>c" },
				opleader = { line = "<leader>c" },
			})
		end,
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		opts = {},
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
	},
	-- { "mg979/vim-visual-multi" },
	{ "christoomey/vim-tmux-navigator" },
	{
		"lukas-reineke/indent-blankline.nvim",
		event = { "BufReadPre", "BufNewFile" },
		main = "ibl",
		opts = {
			indent = { char = "┊" },
		},
	},
}
