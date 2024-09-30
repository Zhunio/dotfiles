return {
	{
		"Zhunio/alpha-nvim",
		branch = "update-theta-theme",
		config = function()
			local alpha = require("alpha")
			local theta = require("alpha.themes.theta")
			local dashboard = require("alpha.themes.dashboard")

			local function set_alpha_header()
				theta.header.val = {
					[[                                                                     ]],
					[[       ████ ██████           █████      ██                     ]],
					[[      ███████████             █████                             ]],
					[[      █████████ ███████████████████ ███   ███████████   ]],
					[[     █████████  ███    █████████████ █████ ██████████████   ]],
					[[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
					[[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
					[[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
					[[                                                                       ]],
				}
			end

			local function set_alpha_buttons()
				theta.buttons.val = {
					{ type = "text", val = "Quick links", opts = { hl = "AlphaGroupTitle", position = "center" } },
					{ type = "padding", val = 1 },
					dashboard.button("u", "  update", ":Lazy sync<CR>"),
					dashboard.button("q", "  quit", ":qa<CR>"),
				}
			end

			local function set_alpha_padding()
				local current_win = vim.api.nvim_get_current_win()
				local win_height = vim.api.nvim_win_get_height(current_win)
				local slices = win_height / 100

				local header_height = #theta.header.val
				local header_padding = slices * 25 - (header_height / 2)

				local section_mru_height = 10
				local section_mru_padding = slices * 70 - header_padding - header_height - (section_mru_height / 2)

				local buttons_padding = 1

				theta.header_padding.val = math.floor(header_padding)
				theta.section_mru_padding.val = math.floor(section_mru_padding)
				theta.buttons_padding.val = math.floor(buttons_padding)
			end

			set_alpha_header()
			set_alpha_buttons()
			set_alpha_padding()

			alpha.setup(theta.config)
		end,
	},
}
