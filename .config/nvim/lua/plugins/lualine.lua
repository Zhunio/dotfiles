return {
	"nvim-lualine/lualine.nvim",
	event = { "BufReadPost", "BufNewFile" },
	dependencies = {
		{ "nvim-tree/nvim-web-devicons" },
		{ "yavorski/lualine-macro-recording.nvim" },
	},
	config = function()
		require("lualine").setup({
			options = {
				theme = "catppuccin",
			},
			sections = {
				lualine_c = { "macro_recording", "%S" },
			},
		})
	end,
}
