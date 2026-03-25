return {
	"CopilotC-Nvim/CopilotChat.nvim",
	cmd = { "CopilotChat" },
	cond = function()
		return vim.fn.executable("gh") == 1
	end,
    --stylua: ignore
	keys = {
		{ "<leader>gg", function() require("CopilotChat").open({ window = { layout = "vertical" } }) end, mode = { "n", "v" }, desc = "Copilot: Open (Vertical)" },
		{ "<leader>gs", function() require("CopilotChat").open({ window = { layout = "horizontal" } }) end, mode = { "n", "v" }, desc = "Copilot: Open (Horizontal)" },
		{ "<leader>gr", ":CopilotChatReset<CR>", mode = { "n", "v" }, desc = "Copilot: Reset" },
		{ "<leader>gx", ":CopilotChatClose<CR>", mode = { "n", "v" }, desc = "Copilot: Close" },
		{ "<leader>gq", ":CopilotChatStop<CR>", mode = { "n", "v" }, desc = "Copilot: Stop" },
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
        desc = "Copilot: Prompt",
		},
	},
	dependencies = {
		{ "github/copilot.vim" },
	},
	build = "make tiktoken", -- Only on MacOS or Linux
	opts = {
		model = "gpt-5.2-codex",
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
}
