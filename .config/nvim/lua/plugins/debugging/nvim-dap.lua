return {
	{
		"mfussenegger/nvim-dap",
    --stylua: ignore
		keys = {
			{ "<leader>dd", function() require("dap").continue() end },
			{ "<leader>dx", function() require("dap").terminate() end },
			{ "<leader>dt", function() require("dapui").toggle() end },
			{ "<leader>dc", function() require("dap").run_to_cursor() end },
			{ "<leader>db", function() require("dap").toggle_breakpoint() end },
			{ "<leader>do", function() require("dap").step_over() end },
			{ "<leader>di", function() require("dap").step_into() end },
			{ "<leader>dO", function() require("dap").step_out() end },
			{ "<leader>dk", function() require("dap").up() end },
			{ "<leader>dj", function() require("dap").down() end },
			{ "<leader>dh", function() require("dap.ui.widgets").hover() end },
			{ "<leader>dp", function() require("dap.ui.widgets").preview() end },
			{ "<leader>df", function() require("dap.ui.widgets").centered_float(require('dap.ui.widgets').frames) end },
			{ "<leader>ds", function() require("dap.ui.widgets").centered_float(require('dap.ui.widgets').scopes) end },
		},
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
			"ibhagwan/fzf-lua",
		},
		config = function()
			require("fzf-lua").register_ui_select()

			local dap = require("dap")
			local dapui = require("dapui")
			local dap_virtual_text = require("nvim-dap-virtual-text")

			dapui.setup()
			dap_virtual_text.setup()

			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end

			local icons = {
				Stopped = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
				Breakpoint = " ",
				BreakpointCondition = " ",
				BreakpointRejected = { " ", "DiagnosticError" },
				LogPoint = ".>",
			}

			vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

			for name, sign in pairs(icons) do
				sign = type(sign) == "table" and sign or { sign }
				vim.fn.sign_define(
					"Dap" .. name,
					{ text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
				)
			end

			for _, adapter in ipairs({ "pwa-node", "pwa-chrome" }) do
				dap.adapters[adapter] = {
					type = "server",
					host = "localhost",
					port = "${port}",
					executable = {
						command = "node",
						args = {
							vim.fn.expand(
								"~/.local/share/nvim/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js"
							),
							"${port}",
						},
					},
				}
			end

			for _, language in ipairs({ "javascript", "typescript" }) do
				dap.configurations[language] = {
					{
						type = "pwa-node",
						request = "attach",
						name = "Node.js: Attach to Process",
						processId = require("dap.utils").pick_process,
						cwd = "${workspaceFolder}",
						sourceMaps = true,
					},
					{
						type = "pwa-chrome",
						request = "launch",
						name = "Chrome: Launch to Debug URL",
						url = function()
							local co = coroutine.running()
							return coroutine.create(function()
								vim.ui.input({
									prompt = "Enter URL: ",
									default = "http://localhost:3000",
								}, function(url)
									if url == nil or url == "" then
										return
									else
										coroutine.resume(co, url)
									end
								end)
							end)
						end,
						webRoot = "${workspaceFolder}",
						skipFiles = { "<node_internals>/**" },
						protocol = "inspector",
						sourceMaps = true,
						userDataDir = false,
					},
				}
			end

			dap.configurations.java = {
				{
					type = "java",
					request = "attach",
					name = "Java: Attach to Debug",
					hostName = "127.0.0.1",
					port = 5005,
				},
			}

			local vscode = require("dap.ext.vscode")
			local json = require("plenary.json")
			vscode.json_decode = function(str)
				return vim.json.decode(json.json_strip_comments(str))
			end
		end,
	},
}
