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
	config = function()
		local dap = require("dap")
		local dap_ui = require("dapui")
		local dap_vscode = require("dap-vscode-js")

		dap_vscode.setup({
			debugger_path = vim.fn.resolve(vim.fn.stdpath("data") .. "/lazy/vscode-js-debug"),
			adapters = {
				"chrome",
				"pwa-node",
				"pwa-chrome",
				"node",
				"node-terminal",
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
					port = 9229,
					outFiles = { "${workspaceFolder}/dist/**/*.js" },
					-- sourceMaps = true,
				},
			}
		end

		dap.listeners.before.attach.dapui_config = dap_ui.open
		dap.listeners.before.launch.dapui_config = dap_ui.open
		dap.listeners.before.event_terminated.dapui_config = dap_ui.close
		dap.listeners.before.event_exited.dapui_config = dap_ui.close

		vim.keymap.set("n", "<leader>dr", dap.continue)
		vim.keymap.set("n", "<leader>ds", dap.close)
		vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint)
		vim.keymap.set("n", "<leader>dj", dap.step_over)
		vim.keymap.set("n", "<leader>di", dap.step_into)
		vim.keymap.set("n", "<leader>do", dap.step_out)
		vim.keymap.set("n", "<leader>d?", function()
			dap_ui.eval(nil, { enter = true })
		end)

		vim.api.nvim_set_hl(0, "DapBreakpoint", { ctermbg = 0, fg = "#993939", bg = "#31353f" })
		vim.api.nvim_set_hl(0, "DapLogPoint", { ctermbg = 0, fg = "#61afef", bg = "#31353f" })
		vim.api.nvim_set_hl(0, "DapStopped", { ctermbg = 0, fg = "#98c379", bg = "#31353f" })

		vim.fn.sign_define(
			"DapBreakpoint",
			{ text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
		)
		vim.fn.sign_define(
			"DapBreakpointCondition",
			{ text = " ", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
		)
		vim.fn.sign_define(
			"DapBreakpointRejected",
			{ text = " ", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
		)
		vim.fn.sign_define(
			"DapLogPoint",
			{ text = " ", texthl = "DapLogPoint", linehl = "DapLogPoint", numhl = "DapLogPoint" }
		)
		vim.fn.sign_define(
			"DapStopped",
			{ text = "", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" }
		)
	end,
}
