return {
	{ "rcasia/neotest-java", ft = "java" },
	{ "nvim-neotest/neotest-jest", ft = "javascript" },
	-- { "Zhunio/neotest-karma", ft = "javascript" },
	{
		"nvim-neotest/neotest",
    --stylua: ignore
		keys = {
			{ "<leader>tt", function() require("neotest").run.run() end, desc = "Neotest: Run Test" },
			{ "<leader>tl", function() require("neotest").run.run_last() end, desc = "Neotest: Run Last Test" },
			{ "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Neotest: Run File" },
			{ "<leader>ta", function() require("neotest").run.run({suite = true}) end, desc = "Neotest: Run All Tests" },
			{ "<leader>ts", function() require("neotest").run.stop() end, desc = "Neotest: Stop Test" },
			{ "<leader>te", function() require("neotest").summary.toggle() end, desc = "Neotest: Toggle Summary" },
			{ "<leader>to", function() require("neotest").output.open({ enter = true }) end, desc = "Neotest: Open Output" },
			{ "<leader>tp", function() require("neotest").output_panel.toggle() end, desc = "Neotest: Toggle Output Panel" },
		},
		dependencies = {
			"antoinemadec/FixCursorHold.nvim",
		},
		config = function()
			require("neotest").setup({
				summary = {
					open = "botright vsplit | vertical resize 100",
				},
				adapters = {
					require("neotest-java")({}),
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
