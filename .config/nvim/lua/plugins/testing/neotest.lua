return {
	{
		"nvim-neotest/neotest",
    --stylua: ignore
		keys = {
			{ "<leader>td", function() require("neotest").run.run({ strategy = "dap" }) end, desc = "Neotest: Debug Test" },

			{ "<leader>tt", function() require("neotest").run.run() end, desc = "Neotest: Run Test" },
			{ "<leader>tl", function() require("neotest").run.run_last() end, desc = "Neotest: Run Last Test" },

			{ "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Neotest: Run File" },
			{ "<leader>ta", function() require("neotest").run.run({suite = true}) end, desc = "Neotest: Run All Tests" },
			{ "<leader>tx", function() require("neotest").run.stop() end, desc = "Neotest: Stop Test" },

			{ "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Neotest: Toggle Summary" },
			{ "<leader>to", function() require("neotest").output.open({ enter = true }) end, desc = "Neotest: Open Output" },
			{ "<leader>tp", function() require("neotest").output_panel.toggle() end, desc = "Neotest: Toggle Output Panel" },

			{ "<leader>tww", function() require("neotest").watch.watch() end, desc = "Neotest: Watch Test" },
			{ "<leader>twf", function() require("neotest").watch.watch(vim.fn.expand('%')) end, desc = "Neotest: Watch File" },
			{ "<leader>tws", function() require("neotest").watch.stop() end, desc = "Neotest: Watch Stop" },
			{ "<leader>twt", function() require("neotest").watch.toggle() end, desc = "Neotest: Watch Toggle" },
		},
		dependencies = {
			"antoinemadec/FixCursorHold.nvim",
			"rcasia/neotest-java",
			"nvim-neotest/neotest-jest",
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
