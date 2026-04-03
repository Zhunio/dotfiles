return {
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		cmd = "Ibl",
		main = "ibl",
		init = function()
			vim.api.nvim_create_user_command("Ibl", function()
				require("lazy").load({ plugins = { "indent-blankline.nvim" } })
			end, { desc = "Load indent-blankline.nvim" })
		end,
		opts = function()
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

			return {
				indent = {
					char = "▏",
					highlight = highlight,
				},
				scope = {
					char = "▎",
					highlight = highlight,
				},
			}
		end,
		config = function(_, opts)
			require("ibl").setup(opts)
		end,
	},
}
