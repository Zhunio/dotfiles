return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			options = {
				theme = "tokyonight",
			},
		},
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			local colors = require("tokyonight.colors")
			local util = require("tokyonight.util")

			colors.styles.nightowl = function()
				---@type Palette
				local storm = vim.deepcopy(util.mod("tokyonight.colors.storm"))

				storm.bg = "#011627"
				storm.bg_dark = storm.bg

				storm.bg_highlight = "#021320"

				return storm
			end

			require("tokyonight").setup({
				style = "nightowl",
				---@param c ColorScheme
				on_colors = function(c)
					c.diff.add = util.blend_bg(c.green, 0.10) -- diffview: added line bg
					c.diff.delete = util.blend_bg(c.red1, 0.10) -- diffview: deleted line bg
					c.diff.change = util.blend_bg(c.green, 0.10) -- diffview: changed line bg
					c.diff.text = util.blend_bg(c.green, 0.35) -- diffview: changed portion of changed line bg

					c.git.add = c.green -- gitsigns|diffview: added fg
					c.git.delete = c.red1 -- gitsigns|diffview: deleted fg
					c.git.change = c.blue -- gitsigns|diffview: changed fg
				end,
			})
			vim.cmd.colorscheme("tokyonight")
		end,
	},
}
