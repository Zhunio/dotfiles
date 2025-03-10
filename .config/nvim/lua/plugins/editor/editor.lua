return {
	{ "christoomey/vim-tmux-navigator" },
	{
		"nvim-lualine/lualine.nvim",
		opts = {
			options = {
				theme = "catppuccin",
			},
		},
	},
	{
		"numToStr/Comment.nvim",
		keys = {
			{ "<leader>c", mode = { "n", "x", "o" } },
		},
		config = function()
			require("Comment").setup({
				toggler = { line = "<leader>c" },
				opleader = { line = "<leader>c" },
			})

			local ft = require("Comment.ft")
			-- set only line comment
			ft.set("http", "#%s")
		end,
	},
	{
		"arnamak/stay-centered.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			skip_filetypes = { "alpha", "neo-tree", "floggraph", "copilot-chat" },
		},
	},
	{
		"szw/vim-maximizer",
		keys = {
			{ "<C-f>", ":MaximizerToggle<CR>" },
		},
	},
}
