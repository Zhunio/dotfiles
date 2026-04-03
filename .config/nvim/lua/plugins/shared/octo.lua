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
		end,
	},
}
