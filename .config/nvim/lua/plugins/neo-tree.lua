return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		cmd = { "Neotree" },
		keys = {
			{ "<leader>ef", ":Neotree reveal=true position=float toggle=true<CR>", desc = "Neotree: Toggle Sidenav" },
			{ "<leader>ee", ":Neotree reveal=true position=left toggle=true<CR>", desc = "Neotree: Open" },
		},
		opts = {
			filesystem = {
				filtered_items = {
					visible = true,
				},
			},
		},
	},
}
