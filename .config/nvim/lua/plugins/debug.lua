return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"theHamsta/nvim-dap-virtual-text",
		"mxsdev/nvim-dap-vscode-js",
		{
			"microsoft/vscode-js-debug",
			build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
		},
	},
  --stylua: ignore
  keys = {
    { "<leader>dr", function() require('dap').continue() end },
    { "<leader>dc", function() require('dap').run_to_cursor() end },
    { "<leader>db", function() require('dap').toggle_breakpoint() end },
    { "<leader>di", function() require('dap').step_into() end },
    { "<leader>dO", function() require('dap').step_out() end },
    { "<leader>do", function() require('dap').step_over() end },
    { "<leader>dl", function() require('dap').run_last() end },
    { "<leader>dp", function() require('dap').pause() end },
    { "<leader>dt", function() require('dap').terminate() end },
  },
	config = function()
		local dap = require("dap")
		local dap_ui = require("dapui")
		local dap_vscode = require("dap-vscode-js")

		dap_vscode.setup({
			debugger_path = vim.fn.resolve(vim.fn.stdpath("data") .. "/lazy/vscode-js-debug"),
			adapters = {
				"pwa-node",
			},
		})

		dap_ui.setup()

		for _, language in ipairs({ "javascript", "typescript" }) do
			dap.configurations[language] = {
				{
					type = "pwa-node",
					request = "launch",
					name = "Debug & Launch Node.js file",
					program = "${file}",
					cwd = "${workspaceFolder}",
					sourceMaps = true,
				},
				{
					type = "pwa-node",
					request = "attach",
					name = "Debug & Attach to Node.js process (make sure process was started with --inspect)",
					cwd = "${workspaceFolder}",
					skipFiles = {
						"<node_internals>/**",
					},
				},
			}
		end

		dap.listeners.before.attach.dapui_config = dap_ui.open
		dap.listeners.before.launch.dapui_config = dap_ui.open
		dap.listeners.before.event_terminated.dapui_config = dap_ui.close
		dap.listeners.before.event_exited.dapui_config = dap_ui.close

		local colors = require("catppuccin.palettes").get_palette("mocha")
		vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = colors.red })
		vim.api.nvim_set_hl(0, "DapLogPoint", { fg = colors.blue })
		vim.api.nvim_set_hl(0, "DapStopped", { fg = colors.green })
		vim.fn.sign_define("DapBreakpoint", { text = " ", texthl = "DapBreakpoint" })
		vim.fn.sign_define("DapBreakpointCondition", { text = " ", texthl = "DapBreakpoint" })
		vim.fn.sign_define("DapBreakpointRejected", { text = " ", texthl = "DapBreakpoint" })
		vim.fn.sign_define("DapLogPoint", { text = " ", texthl = "DapLogPoint" })
		vim.fn.sign_define("DapStopped", { text = " ", texthl = "DapStopped" })
	end,
}
