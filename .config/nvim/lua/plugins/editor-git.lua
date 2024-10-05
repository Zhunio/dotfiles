return {
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		cmd = { "DiffViewOpen", "NeoGit" },
		config = function()
			local gitsigns = require("gitsigns")

			gitsigns.setup({
				signs = {
					add = { text = "┃" },
					change = { text = "┃" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
					untracked = { text = "┆" },
				},
				signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
				numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
				linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
				word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
				watch_gitdir = { follow_files = true },
				auto_attach = true,
				attach_to_untracked = false,
				current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
				current_line_blame_opts = {
					virt_text = true,
					virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
					delay = 1000,
					ignore_whitespace = false,
					virt_text_priority = 100,
				},
				current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
				-- current_line_blame_formatter_opts = {
				-- 	relative_time = false,
				-- },
				sign_priority = 6,
				update_debounce = 100,
				status_formatter = nil, -- Use default
				max_file_length = 40000, -- Disable if file is longer than this (in lines)
				preview_config = {
					-- Options passed to nvim_open_win
					border = "single",
					style = "minimal",
					relative = "cursor",
					row = 0,
					col = 1,
				},
			})

			vim.keymap.set("n", "gS", gitsigns.stage_hunk)
			vim.keymap.set("n", "gU", gitsigns.undo_stage_hunk)
			vim.keymap.set("n", "gC", gitsigns.reset_hunk)
			vim.keymap.set("n", "gs", gitsigns.stage_buffer)
			vim.keymap.set("n", "gu", gitsigns.reset_buffer_index)
			vim.keymap.set("n", "gc", gitsigns.reset_buffer)
			vim.keymap.set("n", "gj", gitsigns.next_hunk)
			vim.keymap.set("n", "gk", gitsigns.prev_hunk)
			vim.keymap.set("n", "gK", gitsigns.preview_hunk)
			vim.keymap.set("n", "gt", gitsigns.toggle_current_line_blame)
		end,
	},
	{
		"sindrets/diffview.nvim",
		cmd = { "DiffViewOpen" },
	},
	{
		"NeogitOrg/neogit",
		cmd = { "Neogit" },
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			local neogit = require("neogit")

			-- Fix dash lines in diff view (https://github.com/sindrets/diffview.nvim/issues/35)
			-- vim.opt.fillchars = vim.opt.fillchars + "diff:╱"
			vim.opt.fillchars = vim.opt.fillchars + "diff: "

			neogit.setup({
				graph_style = "unicode",
				signs = {
					hunk = { "", "" },
					item = { "", "" },
					section = { "", "" },
				},
				commit_editor = {
					staged_diff_split_kind = "auto",
				},
			})
		end,
	},
}
