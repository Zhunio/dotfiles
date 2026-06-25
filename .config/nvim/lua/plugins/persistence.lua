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
				"folds", -- restore fold state and fold-related local options
				"help", -- restore help windows
				"resize", -- restore editor size using 'lines' and 'columns'
				"tabpages", -- restore all tab pages
				"winpos", -- restore the outer editor window position
				"winsize", -- restore split window sizes
			}
			require("persistence").setup({
				need = 0, -- Set to 0 to always save
				branch = true, -- use git branch to save session
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
