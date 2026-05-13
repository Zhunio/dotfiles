return {
	{
		"pwntester/octo.nvim",
		cmd = { "Octo" },
		keys = {
			{ "<leader>oi", ":Octo issue list<CR>", desc = "Octo Issue List" },
			{ "<leader>oo", ":Octo pr list<CR>", desc = "Octo PR List" },
		},
		dependencies = { "ibhagwan/fzf-lua" },
		config = function()
			require("octo").setup({
				picker = "fzf-lua",
				use_local_fs = true,
			})
			local Layout = require("octo.reviews.layout").Layout
			local init_layout = Layout.init_layout
			Layout.init_layout = function(self)
				init_layout(self)
				vim.api.nvim_set_hl(require("octo.constants").OCTO_REVIEW_RIGHT_HIGHLIGHT_NS, "DiffText", { bg = "#004000" })
			end
		end,
	},
}
