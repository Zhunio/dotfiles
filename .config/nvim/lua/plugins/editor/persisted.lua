return {
	{
		"olimorris/persisted.nvim",
		lazy = false,
		config = function()
			local persisted = require("persisted")

			vim.api.nvim_create_autocmd("User", {
				pattern = "PersistedSavePre",
				callback = function()
					for _, buf in ipairs(vim.api.nvim_list_bufs()) do
						if vim.bo[buf].filetype == "alpha" then
							vim.cmd("Alpha")
						elseif vim.bo[buf].filetype == "octo" then
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
