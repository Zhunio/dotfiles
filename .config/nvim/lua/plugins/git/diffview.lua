return {
	{
		"sindrets/diffview.nvim",
		cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    --stylua: ignore
    keys = {
    },
		opts = {
			enhanced_diff_hl = true,
		},
		init = function()
			-- Fix dash lines in diff view (https://github.com/sindrets/diffview.nvim/issues/35)
			-- vim.opt.fillchars = vim.opt.fillchars + "diff:╱"
			vim.opt.fillchars = vim.opt.fillchars + "diff: "

			local function select_git_branch(on_branch_selected)
				local builtin = require("telescope.builtin")
				local actions = require("telescope.actions")
				local action_state = require("telescope.actions.state")

				local function on_entry_selected(prompt_bufnr)
					actions.close(prompt_bufnr)

					local selection = action_state.get_selected_entry()
					local selected_branch = selection.value

					on_branch_selected(selected_branch)
				end

				builtin.git_branches({
					attach_mappings = function()
						actions.select_default:replace(on_entry_selected)
						return true
					end,
				})
			end

			local function diff_branches(options)
				options = options or {}
				options.is_simmetric = options.is_simmetric or false

				select_git_branch(function(branch_one)
					select_git_branch(function(branch_two)
						local cmd = ""

						if options.is_simmetric then
							cmd = ":DiffviewOpen " .. branch_one .. "..." .. branch_two .. " --imply-local"
						else
							cmd = ":DiffviewOpen " .. branch_one .. ".." .. branch_two
						end

						vim.cmd(cmd)
						print(cmd)
					end)
				end)
			end

			local function set_diffview_keymaps()
				local keymapOptions = { noremap = true, silent = true, buffer = true }

				vim.keymap.set("n", "q", ":tabclose<CR>", keymapOptions)
			end

			local keymapOptions = { noremap = true, silent = true }
      --stylua: ignore
      -- vim.keymap.set('n', '<leader>dd', function() diff_branches() end, keymapOptions)
      --stylua: ignore
      -- vim.keymap.set('n', '<leader>ds', function() diff_branches({ is_simmetric = true}) end, keymapOptions)
      --stylua: ignore
   --    vim.keymap.set('n', '<leader>dd', ':DiffviewFileHistory<CR>', keymapOptions)
			-- vim.keymap.set("n", "<leader>df", ":DiffviewFileHistory %<CR>", keymapOptions)

			vim.api.nvim_create_autocmd("FileType", {
				pattern = "Diffview*",
				callback = set_diffview_keymaps,
			})
		end,
	},
}
