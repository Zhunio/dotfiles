return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			local nightowl_bg = "#011627"
			local nightowl_panel = "#0b253a"
			local nightowl_crust = "#01111d"
			local nightowl_line_highlight = "#021320"

			require("catppuccin").setup({
				color_overrides = {
					mocha = {
						base = nightowl_bg,
						mantle = nightowl_panel,
						crust = nightowl_crust,
					},
				},
				custom_highlights = {
					CursorLine = { bg = nightowl_line_highlight },
					CursorColumn = { bg = nightowl_line_highlight },
					FzfLuaBorder = { fg = nightowl_panel, bg = nightowl_panel },
					FzfLuaNormal = { bg = nightowl_panel },
					NeoTreeFloatBorder = { fg = nightowl_panel, bg = nightowl_panel },
					NeoTreeFloatNormal = { bg = nightowl_panel },
				},
			})

			vim.cmd("colorscheme catppuccin-mocha")
		end,
	},
}
