local function delete_current_session()
	local persistence = require("persistence")
	local session = persistence.current()

	persistence.stop()

	if vim.fn.delete(session) == 0 then
		vim.notify("Deleted session: " .. session)
	else
		vim.notify("No current session to delete", vim.log.levels.WARN)
	end
end

return {
	{
		"folke/persistence.nvim",
		lazy = false,
    --stylua: ignore
		keys = {
			{ "<leader>zl", mode = { "n" }, function() require("persistence").load() end },
			{ "<leader>zf", mode = { "n" }, function() require("persistence").select() end },
			{ "<leader>zx", mode = { "n" }, delete_current_session },
		},
		config = function()
			vim.opt.sessionoptions = {
				"blank",
				"buffers",
				"curdir",
				"folds",
				"help",
				"tabpages",
				"terminal",
				"winsize",
			}
			require("persistence").setup({
				need = 0, -- Set to 0 to always save
			})

			vim.api.nvim_create_autocmd("VimEnter", {
				nested = true,
				callback = function()
					if vim.fn.argc() == 0 then
						require("persistence").load()
					end
				end,
			})
		end,
	},
}
