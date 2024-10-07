return {
	"nvim-neotest/neotest",
  --stylua: ignore
  keys = {
    { "<leader>te", function() require('neotest').summary.toggle() end },
    { "<leader>to", function() require('neotest').output.open({ auto_close = true }) end },
    { "<leader>tp", function() require('neotest').output_panel.toggle() end },
    { "<leader>tt", function() require('neotest').run.run(vim.fn.expand('%')) end },
    { "<leader>td", function() require('neotest').run.run({ strategy = 'dap' }) end },
    { "<leader>tc", function() require('neotest').run.run() end },
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
