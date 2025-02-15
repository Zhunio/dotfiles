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
		cond = function()
			return vim.fn.executable("gh") == 1
		end,
		init = function()
			vim.keymap.set("i", "<M-w>", "<Plug>(copilot-accept-word)")
			vim.keymap.set("i", "<M-e>", "<Plug>(copilot-accept-line)")
		end,
	},
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		cmd = { "CopilotChat" },
		cond = function()
			return vim.fn.executable("gh") == 1
		end,
		keys = {
			{
				"<leader>gg",
				function()
					local current_win = vim.api.nvim_get_current_win()
					local win_width = vim.api.nvim_win_get_width(current_win)

					if win_width < 160 then
						require("CopilotChat").open({ window = { layout = "horizontal" } })
					else
						require("CopilotChat").open({ window = { layout = "vertical" } })
					end
				end,
				mode = { "n", "v" },
			},
			{ "<leader>gx", ":CopilotChatClose<CR>", mode = { "n", "v" } },
			{ "<leader>gs", ":CopilotChatStop<CR>", mode = { "n", "v" } },
			{ "<leader>gr", ":CopilotChatReset<CR>", mode = { "n", "v" } },
			{
				"<leader>gp",
				function()
					local prompts = {
						"Explain",
						"Review",
						"Fix",
						"Optimize",
						"Docs",
						"Tests",
						"Commit",
					}

					vim.ui.select(prompts, { prompt = "Choose a prompt:" }, function(prompt)
						if prompt then
							vim.cmd("CopilotChat" .. prompt .. "<CR>")
						end
					end)
				end,
				mode = { "n", "v" },
			},
		},
		dependencies = {
			{ "github/copilot.vim" },
			{ "nvim-lua/plenary.nvim", branch = "master" },
		},
		build = "make tiktoken", -- Only on MacOS or Linux
		opts = {
			highlight_headers = false,
			error_header = "> [!ERROR] Error",
			mappings = {
				complete = {
					insert = "<C-p>",
				},
				reset = {
					normal = "<C-r>",
					insert = "<C-r>",
				},
			},
		},
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
