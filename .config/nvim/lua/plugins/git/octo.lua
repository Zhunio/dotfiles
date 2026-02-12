return {
	{
		"pwntester/octo.nvim",
		cmd = { "Octo" },
    --stylua: ignore
    keys = {
      { "<leader>oi", ":Octo issue list<CR>", desc = "Octo Issue List" },
      { "<leader>oo", ":Octo pr list<CR>", desc = "Octo PR List" },
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
