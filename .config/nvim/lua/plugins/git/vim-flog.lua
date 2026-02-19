return {
	{
		"rbong/vim-flog",
		cmd = { "Flog", "Flogsplit", "Floggit" },
		keys = {
			{ "gl", ":Flog -auto-update -sort=date<CR>" },
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
				["format"] = "%h %d %s %ar %an",
			}

			local function commit_under_cursor()
				vim.cmd('call flog#floggraph#yank#Hashes(v:register, ".", v:count1)')
				local commit = vim.fn.getreg("+")
				return commit
			end

			local function diff_commit_under_cursor()
				local commit = commit_under_cursor()
				local cmd = ":DiffviewOpen " .. commit .. "^!"
				vim.cmd(cmd)
			end

			local function cherrypick_commit_under_cursor()
				local commit = commit_under_cursor()
				require("flog").exec("Git cherry-pick " .. commit)
			end

			local function delete_branch_on_commit_under_cursor()
				local commit = commit_under_cursor()
				local branches = vim.fn.systemlist(
					"git branch --format='%(refname:short)' --points-at " .. vim.fn.shellescape(commit)
				)

				if vim.v.shell_error ~= 0 then
					vim.notify("Failed to list branches for commit " .. commit, vim.log.levels.ERROR)
					return
				end

				branches = vim.tbl_filter(function(branch)
					return branch and branch ~= ""
				end, branches)

				if #branches == 0 then
					vim.notify("No local branches point at commit " .. commit, vim.log.levels.INFO)
					return
				end

				vim.ui.select(branches, { prompt = "Delete branch at " .. commit .. ":" }, function(branch)
					if not branch then
						return
					end

					vim.ui.input({ prompt = "Type branch name to confirm delete: " }, function(input)
						if input ~= branch then
							vim.notify("Branch deletion cancelled", vim.log.levels.WARN)
							return
						end

						require("flog").exec("Git branch -d " .. branch)
					end)
				end)
			end

			local function set_flog_keymaps()
				local keymapOptions = { noremap = true, silent = true, buffer = true }

				vim.keymap.set("n", "q", ":quit<CR>", keymapOptions)
				vim.keymap.set("n", "<CR>", diff_commit_under_cursor, keymapOptions)
				vim.keymap.set("n", "cp", cherrypick_commit_under_cursor, keymapOptions)
				vim.keymap.set("n", "bd", delete_branch_on_commit_under_cursor, keymapOptions)
				vim.keymap.set("n", "fa", function()
					require("flog").exec("Git fetch --prune")
				end, keymapOptions)
				vim.keymap.set("n", "pp", function()
					require("flog").exec("Git pull")
				end, keymapOptions)
				vim.keymap.set("n", "Pp", function()
					require("flog").exec("Git push")
				end, keymapOptions)
				vim.keymap.set("n", "Pu", function()
					require("flog").exec("Git push -u origin HEAD")
				end, keymapOptions)
				vim.keymap.set("n", "bb", function()
					local commit = commit_under_cursor()
					vim.ui.input({ prompt = "Branch name: " }, function(name)
						if name and name ~= "" then
							require("flog").exec("Git checkout -b " .. name .. " " .. commit)
						end
					end)
				end, keymapOptions)
			end

			vim.api.nvim_create_autocmd("FileType", {
				pattern = "floggraph",
				callback = set_flog_keymaps,
			})
		end,
	},
}
