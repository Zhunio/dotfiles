return {
	{
		"akinsho/bufferline.nvim",
		version = "*",
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
		config = function()
			vim.keymap.set("n", "<leader>q", function()
				require("close_buffers").delete({ type = "this" })
			end)
		end,
	},
}
