return {
	{
		"romgrk/barbar.nvim",
		event = { "BufReadPre", "BufNewFile" },
		keys = {
			{ "<leader>q", ":BufferClose<CR>", desc = "Buffer: Close" },
			{ "<leader>h", ":BufferPrevious<CR>", desc = "Buffer: Previous" },
			{ "<leader>l", ":BufferNext<CR>", desc = "Buffer: Next" },
			{ "<leader><left>", ":BufferMovePrevious<CR>", desc = "Buffer: Move to Previous" },
			{ "<leader><right>", ":BufferMoveNext<CR>", desc = "Buffer: Move to Next" },
		},
		opts = {
			icons = {
				button = false,
				separator_at_end = false,
			},
			sidebar_filetypes = {
				["neo-tree"] = true,
			},
			maximum_padding = 1,
		},
	},
}
