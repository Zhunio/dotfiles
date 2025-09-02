return {
	{
		"pwntester/octo.nvim",
		keys = {
			{ "<leader>o", ":Octo pr list<CR>" },
		},
		-- commit = "da764ce",
		dependencies = {
			"ibhagwan/fzf-lua",
		},
		config = function()
			require("octo").setup({
				picker = "fzf-lua",
				use_local_fs = true, -- use local files on right side of reviews
			})
		end,
	},
}
