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
			require("bufferline").setup({
				options = {
					max_name_length = 40, -- default ~18
					max_prefix_length = 30, -- path before filename
					tab_size = 30, -- overall tab width
				},
			})
		end,
	},
}
