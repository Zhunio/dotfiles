return {
	{
		"gelguy/wilder.nvim",
		event = "CmdlineEnter",
		config = function()
			local wilder = require("wilder")

			require("wilder").setup({
				modes = { ":" },
			})

			wilder.set_option(
				"renderer",
				wilder.popupmenu_renderer(wilder.popupmenu_border_theme({
					highlights = {
						border = "Normal",
					},
					border = "rounded",
				}))
			)
		end,
	},
}
