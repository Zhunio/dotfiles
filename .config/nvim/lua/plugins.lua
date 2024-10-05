return {
	{
		"numToStr/Comment.nvim",
		event = { "BufReadPre", "BufNewFile" },
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
    ft = { "markdown" },
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	-- { "mg979/vim-visual-multi" },
	{ "christoomey/vim-tmux-navigator" },
}
