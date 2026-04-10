return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			theme = "tokyonight",
		},
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("tokyonight").setup({
				transparent = true,
				styles = {
					sidebars = "transparent",
					floats = "transparent",
					comments = { italic = true },
				},
				--- You can override specific color groups to use other groups or a hex color
				--- function will be called with a ColorScheme table
				---@param colors ColorScheme
				on_colors = function(colors)
					colors.bg_statusline = "NONE"
				end,

				--- You can override specific highlights to use other groups or a hex color
				--- function will be called with a Highlights and ColorScheme table
				---@param highlights tokyonight.Highlights
				---@param colors ColorScheme
				on_highlights = function(highlights, colors)
					highlights.Pmenu = { fg = colors.fg, bg = "NONE" }
				end,
			})

			vim.cmd([[colorscheme tokyonight-night]])
		end,
	},
}
