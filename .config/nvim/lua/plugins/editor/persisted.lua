return {
	{
		"olimorris/persisted.nvim",
		lazy = false,
		config = function()
			local persisted = require("persisted")

			local function should_save()
				local isAlpha = vim.bo.filetype == "alpha"
				if isAlpha then
					return false
				else
				end

				local isEmptyBuffer = vim.api.nvim_buf_get_name(0) == ""
				if isEmptyBuffer then
					persisted.delete()
					return false
				end

				return true
			end

			persisted.setup({
				autoload = true,
				should_save = should_save,
			})
		end,
	},
}
