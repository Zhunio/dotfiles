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
		"echasnovski/mini.pairs",
		event = "InsertEnter",
		version = "*",
    config = function ()
      require('mini.pairs').setup()
    end
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		ft = { "markdown" },
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	-- { "mg979/vim-visual-multi" },
	{ "christoomey/vim-tmux-navigator" },
}
