return {
	{
		"romgrk/barbar.nvim",
		event = { "BufReadPre", "BufNewFile" },
		keys = {
			{ "<leader>q", ":BufferClose<CR>" },
			{ "<leader>h", ":BufferPrevious<CR>" },
			{ "<leader>l", ":BufferNext<CR>" },
			{ "<leader><left>", ":BufferMovePrevious<CR>" },
			{ "<leader><right>", ":BufferMoveNext<CR>" },
		},
		opts = {},
	},
}
