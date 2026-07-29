return {
	{
		"folke/persistence.nvim",
		lazy = false,
    --stylua: ignore
		keys = {
			{ "<leader>zl", mode = { "n" }, function() require("persistence").load() end },
			{ "<leader>zf", mode = { "n" }, function() require("persistence").select() end },
			{ "<leader>zx", mode = { "n" }, function() require("persistence").stop() end }
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
