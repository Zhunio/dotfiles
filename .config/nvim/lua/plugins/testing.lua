return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		"nvim-neotest/neotest-jest",
	},
	config = function()
		require("neotest").setup({
			adapters = {
				require("neotest-jest")({
					jestCommand = "npm test --",
					jestConfigFile = "custom.jest.config.ts",
					env = { CI = true },
					cwd = function(path)
						return vim.fn.getcwd()
					end,
				}),
			},
		})

		-- testing
		vim.keymap.set("n", "<leader>te", ":Neotest summary<CR>")
		vim.keymap.set("n", "<leader>to", ":Neotest output<CR>")
		vim.keymap.set("n", "<leader>tp", ":Neotest output-panel toggle<CR>")
		vim.keymap.set("n", "<leader>tt", ":lua require('neotest').run.run(vim.fn.expand('%'))<CR>")
		vim.keymap.set("n", "<leader>tc", ":lua require('neotest').run.run()<CR>")
	end,
}
