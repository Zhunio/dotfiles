return {
	"esmuellert/codediff.nvim",
	cmd = "CodeDiff",
	opts = {
		highlights = {
			line_insert = "DiffAdd",
			line_delete = "DiffDelete",

			char_insert = "#006000",
			char_delete = "#770001",
		},

		diff = {
			compute_moves = true, -- Detect moved code blocks (opt-in, matches VSCode experimental.showMoves)
		},

		explorer = {
			position = "left", -- "left" or "bottom"
			width = 60,
			height = 15,
			initial_focus = "explorer", -- Initial focus: "explorer", "original", or "modified"
			focus_on_select = true, -- Jump to modified pane after selecting a file (default: stay in explorer)
		},

		history = {
			position = "left", -- "left" or "bottom" (default: bottom)
			width = 100, -- Width when position is "left" (columns)
			height = 15, -- Height when position is "bottom" (lines)
			initial_focus = "history", -- Initial focus: "history", "original", or "modified"
			view_mode = "list", -- "list" or "tree" for files under commits
		},

		keymaps = {
			view = {
				quit = "q", -- Close diff tab
				toggle_explorer = "<leader>b", -- Toggle explorer visibility (explorer mode only)
				focus_explorer = "<leader>e", -- Focus explorer panel (explorer mode only)
				next_hunk = "]c", -- Jump to next change
				prev_hunk = "[c", -- Jump to previous change
				next_file = "]f", -- Next file in explorer/history mode
				prev_file = "[f", -- Previous file in explorer/history mode
				diff_get = "do", -- Get change from other buffer (like vimdiff)
				diff_put = "dp", -- Put change to other buffer (like vimdiff)
				open_in_prev_tab = "gf", -- Open current buffer in previous tab (or create one before)
				close_on_open_in_prev_tab = false, -- Close codediff tab after gf opens file in previous tab
				toggle_stage = "-", -- Stage/unstage current file (works in explorer and diff buffers)
				stage_hunk = "<leader>hs", -- Stage hunk under cursor to git index
				unstage_hunk = "<leader>hu", -- Unstage hunk under cursor from git index
				discard_hunk = "<leader>hr", -- Discard hunk under cursor (working tree only)
				hunk_textobject = "ih", -- Textobject for hunk (vih to select, yih to yank, etc.)
				show_help = "g?", -- Show floating window with available keymaps
				align_move = "gm", -- Temporarily align moved code blocks across panes
				toggle_layout = "t", -- Toggle between side-by-side and inline layout
			},
			explorer = {
				select = "<CR>", -- Open diff for selected file
				hover = "K", -- Show file diff preview
				refresh = "R", -- Refresh git status
				toggle_view_mode = "i", -- Toggle between 'list' and 'tree' views
				stage_all = "S", -- Stage all files
				unstage_all = "U", -- Unstage all files
				restore = "X", -- Discard changes (restore file)
				toggle_changes = "gu", -- Toggle Changes (unstaged) group visibility
				toggle_staged = "gs", -- Toggle Staged Changes group visibility
			},
			history = {
				select = "<CR>", -- Select commit/file or toggle expand
				toggle_view_mode = "i", -- Toggle between 'list' and 'tree' views
				refresh = "R", -- Refresh history (re-fetch commits)
			},
			conflict = {
				accept_incoming = "<leader>ct", -- Accept incoming (theirs/left) change
				accept_current = "<leader>co", -- Accept current (ours/right) change
				accept_both = "<leader>cb", -- Accept both changes (incoming first)
				discard = "<leader>cx", -- Discard both, keep base
				-- Accept all (whole file) - uppercase versions
				accept_all_incoming = "<leader>cT", -- Accept ALL incoming changes
				accept_all_current = "<leader>cO", -- Accept ALL current changes
				accept_all_both = "<leader>cB", -- Accept ALL both changes
				discard_all = "<leader>cX", -- Discard ALL, reset to base
				next_conflict = "]x", -- Jump to next conflict
				prev_conflict = "[x", -- Jump to previous conflict
				diffget_incoming = "2do", -- Get hunk from incoming (left/theirs) buffer
				diffget_current = "3do", -- Get hunk from current (right/ours) buffer
			},
		},
	},
}
