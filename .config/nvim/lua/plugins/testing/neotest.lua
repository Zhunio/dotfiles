return {
	{
		"nvim-neotest/neotest",
    --stylua: ignore
		keys = {
			{ "<leader>tt", function() require("neotest").run.run() end },
			{ "<leader>tl", function() require("neotest").run.run_last() end },
			{ "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end },
			{ "<leader>ta", function() require("neotest").run.run({suite = true}) end },
			{ "<leader>ts", function() require("neotest").run.stop() end },
			{ "<leader>te", function() require("neotest").summary.toggle() end },
			{ "<leader>to", function() require("neotest").output.open({ enter = true }) end },
			{ "<leader>tp", function() require("neotest").output_panel.toggle() end },
		},
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
			"nvim-neotest/neotest-jest",
			-- "Zhunio/neotest-karma",
		},
		config = function()
			require("neotest").setup({
				summary = {
					open = "botright vsplit | vertical resize 100",
				},
				adapters = {
					require("neotest-jest")({
						jestCommand = "npm run test --",
						env = { CI = true },
						cwd = function()
							return vim.fn.getcwd()
						end,
					}),
					-- require("neotest-karma")({}),
				},
			})
		end,
	},
}
