return {
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup({
				toggler = { line = "<leader>c" },
				opleader = { line = "<leader>c" },
			})
		end,
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		opts = {},
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
	},
	-- { "mg979/vim-visual-multi" },
	{ "christoomey/vim-tmux-navigator" },
	{
		"lukas-reineke/indent-blankline.nvim",
		event = { "BufReadPre", "BufNewFile" },
		main = "ibl",
		config = function()
			-- local highlight = {
			-- 	"RainbowRed",
			-- 	"RainbowYellow",
			-- 	"RainbowBlue",
			-- 	"RainbowOrange",
			-- 	"RainbowGreen",
			-- 	"RainbowViolet",
			-- 	"RainbowCyan",
			-- }
			--
			-- local colors = require("catppuccin.palettes").get_palette("mocha")
			-- local hightlight_colors = {
			-- 	RainbowRed = colors.red,
			-- 	RainbowYellow = colors.yellow,
			-- 	RainbowBlue = colors.blue,
			-- 	RainbowOrange = colors.peach,
			-- 	RainbowGreen = colors.green,
			-- 	RainbowViolet = colors.pink,
			-- 	RainbowCyan = colors.lavender,
			-- }
			--
			-- local hooks = require("ibl.hooks")
			-- hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
			-- 	for _, highlight_name in pairs(highlight) do
			-- 		local hightlight_color = hightlight_colors[highlight_name]
			-- 		vim.api.nvim_set_hl(0, highlight_name, { fg = hightlight_color })
			-- 	end
			-- end)
			--
			local indent = require("ibl")
			indent.setup({
				indent = {
					char = "▏", --"│"
					-- highlight = highlight,
				},
			})
		end,
	},
}
