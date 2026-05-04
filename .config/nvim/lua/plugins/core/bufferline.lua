return {
	{
		"akinsho/bufferline.nvim",
		event = { "BufReadPre", "BufNewFile" },
		keys = {
			{ "<leader>q", "<cmd>bdelete<CR>", desc = "Buffer: Close" },
			{ "<leader>h", "<cmd>BufferLineCyclePrev<CR>", desc = "Buffer: Previous" },
			{ "<leader>l", "<cmd>BufferLineCycleNext<CR>", desc = "Buffer: Next" },
			{ "<leader><left>", "<cmd>BufferLineMovePrev<CR>", desc = "Buffer: Move to Previous" },
			{ "<leader><right>", "<cmd>BufferLineMoveNext<CR>", desc = "Buffer: Move to Next" },
		},
		config = function()
			vim.opt.termguicolors = true
			require("bufferline").setup({})
		end,
	},
}
