return {
	{
		"numToStr/Comment.nvim",
		keys = {
			{ "<leader>c", mode = { "n", "x", "o" }, desc = "Comment: Toggle Line" },
		},
		config = function()
			require("Comment").setup({
				toggler = { line = "<leader>c" },
				opleader = { line = "<leader>c" },
			})

			local ft = require("Comment.ft")
			-- set only line comment
			ft.set("http", "#%s")
		end,
	},
}
