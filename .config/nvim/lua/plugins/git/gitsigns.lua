return {
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
    --stylua: ignore
    keys = {
      { "gS", function() require('gitsigns').stage_hunk() end, desc = "GitSigns: State Hunk" },
      { "gU", function() require('gitsigns').undo_stage_hunk() end, desc = "GitSigns: Undo Stage Hunk" },
      { "gC", function() require('gitsigns').reset_hunk() end, desc = "GitSigns: Reset Hunk" },
      { "gs", function() require('gitsigns').stage_buffer() end, desc = "GitSigns: Stage Buffer" },
      { "gu", function() require('gitsigns').reset_buffer_index() end, desc = "GitSigns: Reset Buffer Index" },
      { "gc", function() require('gitsigns').reset_buffer() end, desc = "GitSigns: Reset Buffer" },
      { "gj", function() require('gitsigns').next_hunk() end, desc = "GitSigns: Next Hunk" },
      { "gk", function() require('gitsigns').prev_hunk() end, desc = "GitSigns: Previous Hunk" },
      { "gK", function() require('gitsigns').preview_hunk() end, desc = "GitSigns: Preview Hunk" },
      { "gt", function() require('gitsigns').toggle_current_line_blame() end, desc = "GitSigns: Toggle Current Line Blame" },
    },
		config = function()
			local gitsigns = require("gitsigns")

			gitsigns.setup({
				signs = {
					add = { text = "┃" },
					change = { text = "┃" },
					delete = { text = "" },
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
		end,
	},
}
