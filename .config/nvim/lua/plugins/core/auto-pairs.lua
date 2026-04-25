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

			local colors = require("tokyonight.colors").setup({ style = "nightowl" })
			local highlight_colors = {
				RainbowRed = colors.red,
				RainbowOrange = colors.orange,
				RainbowYellow = colors.yellow,
				RainbowGreen = colors.green,
				RainbowBlue = colors.blue,
				RainbowViolet = colors.purple,
			}

			local hooks = require("ibl.hooks")
			hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
				for _, highlight_name in pairs(highlight) do
					local highlight_color = highlight_colors[highlight_name]
					vim.api.nvim_set_hl(0, highlight_name, { fg = highlight_color })
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
