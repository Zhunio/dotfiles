return {
	{
		"MeanderingProgrammer/render-markdown.nvim",
		ft = { "markdown", "octo", "copilot-chat" },
		config = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "markdown",
				callback = function()
					vim.opt.shiftwidth = 2
					vim.opt.tabstop = 2
				end,
			})

			require("render-markdown").setup({
				render_modes = true,
				sign = { enabled = false },
				code = { left_pad = 2 },
				checkbox = {
					unchecked = { icon = "󰄯 " },
					checked = { icon = "󰄳 " },
				},
			})
		end,
	},
}
