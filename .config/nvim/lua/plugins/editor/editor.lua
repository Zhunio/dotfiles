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
	{
		"nvim-neotest/neotest",
    --stylua: ignore
		keys = {
			{ "<leader>tt", function() require("neotest").run.run() end },
			{ "<leader>tl", function() require("neotest").run.run_last() end },
			{ "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end },
			{ "<leader>ts", function() require("neotest").run.stop() end },
			{ "<leader>te", function() require("neotest").summary.toggle() end },
			{ "<leader>to", function() require("neotest").output.open({ enter = true }) end },
			{ "<leader>tp", function() require("neotest").output_panel.toggle() end },
		},
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
			"nvim-neotest/neotest-jest",
		},
		config = function()
			require("neotest").setup({
				summary = {
					open = "botright vsplit | vertical resize 100",
				},
				adapters = {
					require("neotest-jest")({
						jestCommand = "npm run test --",
						env = { CI = true },
						cwd = function()
							return vim.fn.getcwd()
						end,
					}),
				},
			})
		end,
	},
}
