return {
	"nvim-neotest/neotest",
  --stylua: ignore
  keys = {
    { "<leader>te", function() vim.api.nvim_command(":Neotest summary<CR>") end },
    { "<leader>to", function() vim.api.nvim_command(":Neotest output<CR>") end },
    { "<leader>tp", function() vim.api.nvim_command(":Neotest output-panel toggle<CR>") end },
    { "<leader>tt", function() vim.api.nvim_command(":lua require('neotest').run.run(vim.fn.expand('%'))<CR>") end },
    { "<leader>tc", function() vim.api.nvim_command(":lua require('neotest').run.run()<CR>") end },
  },
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
	end,
}
