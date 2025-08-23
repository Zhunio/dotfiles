return {
	{
		"3rd/image.nvim",
		build = false, -- Disable build step (not needed)
		opts = {
			backend = "kitty", -- Use 'kitty' backend for image display
			processor = "magick_cli", -- Use ImageMagick CLI for image processing
		},
	},
}
