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
				checkbox = {
					unchecked = { icon = " ", highlight = "RenderMarkdownInfo" },
					checked = { icon = "󰄳 " },
					custom = {
						in_progress = {
							raw = "[~]",
							rendered = "",
							highlight = "RenderMarkdownWarn",
							scope_highlight = nil,
						},
					},
				},
			})
		end,
	},
}
