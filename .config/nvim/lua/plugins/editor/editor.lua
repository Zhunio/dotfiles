return {
	{
		"echasnovski/mini.ai",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("mini.ai").setup({})
		end,
	},
	{
		"echasnovski/mini.surround",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("mini.surround").setup({})
		end,
	},
	{
		"github/copilot.vim",
		ft = { "python", "lua", "typescript" },
		init = function()
			vim.keymap.set("i", "<M-w>", "<Plug>(copilot-accept-word)")
			vim.keymap.set("i", "<M-e>", "<Plug>(copilot-accept-line)")
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
		opts = {
			toggler = { line = "<leader>c" },
			opleader = { line = "<leader>c" },
		},
		init = function()
			local ft = require("Comment.ft")
			-- set only line comment
			ft.set("http", "#%s")
		end,
	},
	{
		"arnamak/stay-centered.nvim",
		opts = {
			skip_filetypes = { "alpha", "neo-tree", "floggraph" },
		},
	},
	{
		"szw/vim-maximizer",
		keys = {
			{ "<C-f>", ":MaximizerToggle<CR>" },
		},
	},
}
