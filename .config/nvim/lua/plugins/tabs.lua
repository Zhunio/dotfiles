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
		end,
	},
	{
		"kazhala/close-buffers.nvim",
	},
}
