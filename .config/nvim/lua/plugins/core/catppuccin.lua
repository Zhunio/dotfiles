return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			local nightowl_bg = "#011627"
			local nightowl_panel = "#0b253a"
			local nightowl_crust = "#013661"
			local nightowl_line_highlight = nightowl_panel
			local nightowl_line_number = "#4b6479"
			local nightowl_active_line_number = "#C5E4FD"

			require("catppuccin").setup({
				color_overrides = {
					mocha = {
						base = nightowl_bg,
						mantle = nightowl_panel,
						crust = nightowl_crust,
					},
				},
				integrations = {
					lualine = {
						all = function(colors)
							return {
								normal = {
									b = { bg = colors.crust, fg = colors.blue },
									c = { bg = colors.base, fg = colors.text },
								},
								insert = {
									b = { bg = colors.crust, fg = colors.green },
									c = { bg = colors.base, fg = colors.text },
								},
								terminal = {
									b = { bg = colors.crust, fg = colors.green },
									c = { bg = colors.base, fg = colors.text },
								},
								command = {
									b = { bg = colors.crust, fg = colors.peach },
									c = { bg = colors.base, fg = colors.text },
								},
								visual = {
									b = { bg = colors.crust, fg = colors.mauve },
									c = { bg = colors.base, fg = colors.text },
								},
								replace = {
									b = { bg = colors.crust, fg = colors.red },
									c = { bg = colors.base, fg = colors.text },
								},
								inactive = {
									a = { bg = colors.base, fg = colors.blue },
									b = { bg = colors.crust, fg = colors.surface1, gui = "bold" },
									c = { bg = colors.base, fg = colors.overlay0 },
								},
							}
						end,
					},
				},
				custom_highlights = {
					CursorLine = { bg = nightowl_line_highlight },
					CursorColumn = { bg = nightowl_line_highlight },
					LineNr = { fg = nightowl_line_number },
					CursorLineNr = { fg = nightowl_active_line_number },
					FzfLuaBorder = { fg = nightowl_panel, bg = nightowl_panel },
					FzfLuaNormal = { bg = nightowl_panel },
					NeoTreeNormal = { bg = nightowl_bg },
					NeoTreeNormalNC = { bg = nightowl_bg },
					NeoTreeFloatBorder = { fg = nightowl_panel, bg = nightowl_panel },
					NeoTreeFloatNormal = { bg = nightowl_bg },
				},
			})

			vim.cmd("colorscheme catppuccin-mocha")
		end,
	},
}
