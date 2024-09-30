return {
	{
		"rbong/vim-flog",
		cmd = { "Flog", "Flogsplit", "Floggit" },
		keys = {
			{ "gl", ":Flog<CR>" },
		},
		dependencies = {
			"tpope/vim-fugitive",
		},
		init = function()
			vim.g.flog_enable_extended_chars = 1
			vim.g.flog_enable_dynamic_commit_hl = 1
			vim.g.flog_enable_dynamic_branch_hl = 1
			vim.g.flog_default_opts = {
				["date"] = "short",
				["format"] = "%h %d %s {%an} (%ar)",
			}

			local function diff_open_commit(commit)
				local cmd = ":DiffviewOpen " .. commit .. "^!"

				vim.cmd(cmd)
				print(cmd)
			end

			local function diff_commit_under_cursor()
				vim.cmd('call flog#floggraph#yank#Hashes(v:register, ".", v:count1)')
				local commit = vim.fn.getreg("+")
				diff_open_commit(commit)
			end

			local function set_flog_keymaps()
				local keymapOptions = { noremap = true, silent = true, buffer = true }

				vim.keymap.set("n", "q", ":quit<CR>", keymapOptions)
				vim.keymap.set("n", "<CR>", diff_commit_under_cursor, keymapOptions)
			end

			vim.api.nvim_create_autocmd("FileType", {
				pattern = "floggraph",
				callback = set_flog_keymaps,
			})
		end,
	},
}
