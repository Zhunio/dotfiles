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

			local function branch_from_selection(selected)
				if not (selected and selected[1]) then
					return nil
				end
				local _, branch = selected[1]:match("%s-([%+%*]?)%s+([^ ]+)")
				return branch
			end

			local function select_branch(title, on_select)
				require("fzf-lua").git_branches({
					winopts = { title = title },
					actions = {
						["default"] = function(selected)
							local branch = branch_from_selection(selected)
							if not branch then
								return
							end
							on_select(branch)
						end,
					},
				})
			end

			local function diff_select_compare_branch(base_branch)
				select_branch("Comparing Changes: Compare", function(compare_branch)
					vim.cmd("DiffviewOpen " .. base_branch .. "..." .. compare_branch)
				end)
			end

			local function diff_select_base_branch()
				select_branch("Comparing Changes: Base", function(base_branch)
					diff_select_compare_branch(base_branch)
				end)
			end

			local function delete_branch()
				select_branch("Delete Branch", function(branch)
					local remote_branch = branch:match("^origin/(.+)$")

					if remote_branch then
						require("flog").exec("Git push origin --delete " .. vim.fn.shellescape(remote_branch))
						return
					end

					require("flog").exec("Git branch -d " .. vim.fn.shellescape(branch))
				end)
			end

			local function set_flog_keymaps()
				local keymapOptions = { noremap = true, silent = true, buffer = true }

				vim.keymap.set("n", "q", ":quit<CR>", keymapOptions)
				vim.keymap.set("n", "<CR>", diff_commit_under_cursor, keymapOptions)
				vim.keymap.set("n", "cp", cherrypick_commit_under_cursor, keymapOptions)
				vim.keymap.set("n", "bd", delete_branch, keymapOptions)
				vim.keymap.set("n", "dr", diff_select_base_branch, keymapOptions)
				vim.keymap.set("n", "fa", function() require("flog").exec("Git fetch --prune") end, keymapOptions)
				vim.keymap.set("n", "pp", function() require("flog").exec("Git pull") end, keymapOptions)
				vim.keymap.set("n", "Pp", function() require("flog").exec("Git push") end, keymapOptions)
				vim.keymap.set("n", "Pu", function() require("flog").exec("Git push -u origin HEAD") end, keymapOptions)
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
