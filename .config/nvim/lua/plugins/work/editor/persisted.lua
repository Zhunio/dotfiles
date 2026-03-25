return {
	{
		"olimorris/persisted.nvim",
		lazy = false,
		config = function()
			local persisted = require("persisted")

			vim.api.nvim_create_autocmd("User", {
				pattern = "PersistedLoadPost",
				callback = function()
					local ignored_filetypes = {
						"octo",
						"floggraph",
						"NeogitStatus",
						"NeogitConsole",
						"copilot-chat",
					}

					local valid_buffers = {}

					for _, buf in ipairs(vim.api.nvim_list_bufs()) do
						local is_empty_filetype = vim.bo[buf].filetype == ""
						local is_ignored_filetype = vim.tbl_contains(ignored_filetypes, vim.bo[buf].filetype)

						if is_empty_filetype or is_ignored_filetype then
							vim.api.nvim_buf_delete(buf, { force = true })
						else
							table.insert(valid_buffers, buf)
						end
					end

					if #valid_buffers == 0 then
						vim.cmd(":Alpha")
					end
				end,
			})

			persisted.setup({
				autoload = true,
			})
		end,
	},
}
