return {
	{
		"github/copilot.vim",
		ft = { "python", "lua", "typescript", "markdown", "terraform" },
		cond = function()
			return vim.fn.executable("gh") == 1
		end,
		init = function()
			vim.keymap.set("i", "<M-w>", "<Plug>(copilot-accept-word)")
			vim.keymap.set("i", "<M-e>", "<Plug>(copilot-accept-line)")
		end,
	},
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		cmd = { "CopilotChat" },
		cond = function()
			return vim.fn.executable("gh") == 1
		end,
    --stylua: ignore
		keys = {
			{ "<leader>gg", function() require("CopilotChat").open({ window = { layout = "vertical" } }) end, mode = { "n", "v" } },
			{ "<leader>gv", function() require("CopilotChat").open({ window = { layout = "horizontal" } }) end, mode = { "n", "v" } },
			{ "<leader>gx", ":CopilotChatClose<CR>", mode = { "n", "v" } },
			{ "<leader>gs", ":CopilotChatStop<CR>", mode = { "n", "v" } },
			{ "<leader>gr", ":CopilotChatReset<CR>", mode = { "n", "v" } },
			{
				"<leader>gp",
				function()
					local prompts = {
						"Explain",
						"Review",
						"Fix",
						"Optimize",
						"Docs",
						"Tests",
						"Commit",
					}

					vim.ui.select(prompts, { prompt = "Choose a prompt:" }, function(prompt)
						if prompt then
							vim.cmd("CopilotChat" .. prompt .. "<CR>")
						end
					end)
				end,
				mode = { "n", "v" },
			},
		},
		dependencies = {
			{ "github/copilot.vim" },
		},
		build = "make tiktoken", -- Only on MacOS or Linux
		opts = {
			highlight_headers = false,
			error_header = "> [!ERROR] Error",
			mappings = {
				complete = {
					insert = "<C-p>",
				},
				reset = {
					normal = "<C-r>",
					insert = "<C-r>",
				},
			},
		},
	},
}
