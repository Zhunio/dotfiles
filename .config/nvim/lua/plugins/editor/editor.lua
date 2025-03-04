return {
	{
		"echasnovski/mini.nvim",
		config = function()
			require("mini.ai").setup({})
			require("mini.surround").setup({})
			require("mini.bracketed").setup({
				treesitter = { suffix = "", options = {} },
			})

			vim.keymap.set("n", "]t", ":tabnext<CR>")
			vim.keymap.set("n", "[t", ":tabprevious<CR>")
		end,
	},
	{ "christoomey/vim-tmux-navigator" },
	{
		"romgrk/barbar.nvim",
		event = { "BufReadPre", "BufNewFile" },
		keys = {
			{ "<leader>q", ":BufferClose<CR>" },
			{ "<leader>h", ":BufferPrevious<CR>" },
			{ "<leader>l", ":BufferNext<CR>" },
			{ "<leader><left>", ":BufferMovePrevious<CR>" },
			{ "<leader><right>", ":BufferMoveNext<CR>" },
		},
		opts = {},
	},
	{
		"nvim-lualine/lualine.nvim",
		opts = {
			options = {
				theme = "catppuccin",
			},
		},
	},
	{
		"numToStr/Comment.nvim",
		keys = {
			{ "<leader>c", mode = { "n", "x", "o" } },
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
	{
		"arnamak/stay-centered.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			skip_filetypes = { "alpha", "neo-tree", "floggraph", "copilot-chat" },
		},
	},
	{
		"szw/vim-maximizer",
		keys = {
			{ "<C-f>", ":MaximizerToggle<CR>" },
		},
	},
}
