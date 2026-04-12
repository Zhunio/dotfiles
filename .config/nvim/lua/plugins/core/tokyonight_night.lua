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

			require("tokyonight").setup({ style = "nightowl" })
			vim.cmd.colorscheme("tokyonight")
		end,
	},
}
