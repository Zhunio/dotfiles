return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		cmd = { "Neotree" },
		keys = {
			{ "<leader>ef", ":Neotree reveal=true position=float toggle=true<CR>" },
			{ "<leader>ee", ":Neotree reveal=true position=left toggle=true<CR>" },
		},
		-- dependencies = { { "3rd/image.nvim", lazy = true } },
		opts = {
			filesystem = {
				filtered_items = {
					visible = true,
				},
			},
			window = {
				mappings = {
					-- ["P"] = { "toggle_preview", config = { use_image_nvim = true } },
				},
			},
		},
	},
}
