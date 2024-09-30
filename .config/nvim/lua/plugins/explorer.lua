return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
	},
	config = function()
		require("neo-tree").setup({})
		vim.keymap.set("n", "<leader>ee", ":Neotree reveal=true toggle=true<CR>")
		vim.keymap.set("n", "<leader>ef", ":Neotree reveal=true position=float toggle=true<CR>")
		vim.keymap.set("n", "<leader>ed", ":DBUIToggle<CR>")
	end,
}
