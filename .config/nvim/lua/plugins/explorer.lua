return {
	-- {
	-- 	"nvim-tree/nvim-tree.lua",
	-- 	config = function()
	-- 		require("nvim-tree").setup({
	-- 			renderer = {
	-- 				indent_markers = { enable = true },
	-- 			},
	-- 			git = {
	-- 				ignore = false,
	-- 			},
	-- 		})
	-- 		vim.keymap.set("n", "<leader>ee", ":NvimTreeFindFileToggle<CR>")
	-- 	end,
	-- },
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		cmd = { "Neotree" },
		keys = {
			{ "<leader>ef", ":Neotree reveal=true position=float toggle=true<CR>" },
			{ "<leader>ee", ":Neotree reveal=true position=left toggle=true<CR>" },
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
	},
}
