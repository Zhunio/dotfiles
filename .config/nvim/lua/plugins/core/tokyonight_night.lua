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
					c.diff.add = "#002800" -- delta plus-style
					c.diff.delete = "#3f0001" -- delta minus-style
					c.diff.change = "#002800" -- delta changed/new side matches plus-style
					c.diff.text = "#006000" -- delta plus-emph-style

					c.git.add = c.green -- gitsigns|diffview: added fg
					c.git.delete = c.red1 -- gitsigns|diffview: deleted fg
					c.git.change = c.blue -- gitsigns|diffview: changed fg
				end,
			})
			vim.cmd.colorscheme("tokyonight")
		end,
	},
}
