return {
	"folke/flash.nvim",
	event = "VeryLazy",
	opts = {
		modes = {
			search = { enabled = true, highlight = { backdrop = true } },
		},
	},
	keys = {
		{
			"s",
			mode = { "n", "x", "o" },
			function()
				require("flash").treesitter()
			end,
			desc = "Flash Treesitter",
		},
	},
}
