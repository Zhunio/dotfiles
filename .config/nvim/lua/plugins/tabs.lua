return {
	{
		"akinsho/bufferline.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("bufferline").setup({
				options = {
					truncate_names = false,
					mode = "buffers",
					offsets = {
						{
							filetype = "NvimTree",
							highlight = "Directory",
							separator = true,
						},
					},
				},
			})

			vim.keymap.set("n", "<leader><left>", ":BufferLineMovePrev<CR>")
			vim.keymap.set("n", "<leader><right>", ":BufferLineMoveNext<CR>")
		end,
	},
	{
		"kazhala/close-buffers.nvim",
  -- stylua: ignore
		keys = {
			{ "<leader>q", function() require("close_buffers").delete({ type = "this" }) end },
		},
	},
}
