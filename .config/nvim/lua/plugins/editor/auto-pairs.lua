return {
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		event = { "BufReadPre", "BufNewFile" },
		main = "ibl",
		config = function()
			local highlight = {
				"RainbowRed",
				"RainbowOrange",
				"RainbowYellow",
				"RainbowGreen",
				"RainbowBlue",
				"RainbowViolet",
			}

			local C = require("catppuccin.palettes").get_palette("mocha")
			local hightlight_colors = {
				RainbowRed = C.red,
				RainbowOrange = C.peach,
				RainbowYellow = C.yellow,
				RainbowGreen = C.green,
				RainbowBlue = C.blue,
				RainbowViolet = C.mauve,
			}

			local hooks = require("ibl.hooks")
			hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
				for _, highlight_name in pairs(highlight) do
					local hightlight_color = hightlight_colors[highlight_name]
					vim.api.nvim_set_hl(0, highlight_name, { fg = hightlight_color })
				end
			end)

			local indent = require("ibl")
			indent.setup({
				indent = {
					char = "▏",
					highlight = highlight,
				},
				scope = {
					char = "▎",
					highlight = highlight,
				},
			})
		end,
	},
}
