return {
	{
		"olimorris/persisted.nvim",
		lazy = false,
		config = function()
			local persisted = require("persisted")

			vim.api.nvim_create_autocmd("User", {
				pattern = "PersistedSavePre",
				callback = function()
					local ignored_filetypes = {
						"octo",
						"floggraph",
						"NeogitStatus",
						"NeogitConsole",
						"copilot-chat",
					}

					for _, buf in ipairs(vim.api.nvim_list_bufs()) do
						if vim.bo[buf].filetype == "alpha" then
							vim.cmd("Alpha")
						elseif vim.tbl_contains(ignored_filetypes, vim.bo[buf].filetype) then
							vim.api.nvim_buf_delete(buf, { force = true })
						end
					end
				end,
			})
			persisted.setup({
				autoload = true,
			})
		end,
	},
}
