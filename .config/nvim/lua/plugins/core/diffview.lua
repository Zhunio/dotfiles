return {
	{
		"sindrets/diffview.nvim",
		cmd = { "DiffviewOpen", "DiffviewFileHistory" },
		config = function()
			-- Fix dash lines in diff view (https://github.com/sindrets/diffview.nvim/issues/35)
			-- vim.opt.fillchars = vim.opt.fillchars + "diff:╱"
			vim.opt.fillchars = vim.opt.fillchars + "diff: "

			local actions = require("diffview.actions")

			require("diffview").setup({
				enhanced_diff_hl = true,
        --stylua: ignore
				keymaps = {
					view = {
						{ "n", "-", actions.toggle_stage_entry, { desc = "Stage / unstage the selected entry" } },
						{ "n", "gd", function() actions.goto_file_edit() vim.lsp.buf.definition() end },
					},
					file_panel = {
						{ "n", "<cr>", actions.focus_entry, { desc = "Focus the selected entry" } },
						{ "n", "s", actions.toggle_stage_entry, { desc = "Stage / unstage the selected entry" } },
						{ "n", "[c", actions.view_windo(function(_, sym) if sym == "b" then vim.cmd("norm! [c") end end), },
						{ "n", "]c", actions.view_windo(function(_, sym) if sym == "b" then vim.cmd("norm! ]c") end end), },
					},
					file_history_panel = {
						{ "n", "[n", actions.select_prev_commit },
						{ "n", "]n", actions.select_next_commit },
						{ "n", "<cr>", actions.focus_entry, { desc = "Focus the selected entry" } },
					},
				},
			})
		end,
	},
}
