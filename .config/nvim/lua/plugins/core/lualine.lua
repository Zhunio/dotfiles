return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = function()
			local theme = require("catppuccin.utils.lualine")()

			return {
				options = {
					theme = theme,
				},
			}
		end,
	},
}
