return {
	{
		"echasnovski/mini.nvim",
		config = function()
			require("mini.ai").setup({})
			require("mini.surround").setup({})
			require("mini.bracketed").setup({
				treesitter = { suffix = "", options = {} },
				comment = { suffix = "", options = {} },
			})

			vim.keymap.set("n", "]t", ":tabnext<CR>")
			vim.keymap.set("n", "[t", ":tabprevious<CR>")
		end,
	},
}
