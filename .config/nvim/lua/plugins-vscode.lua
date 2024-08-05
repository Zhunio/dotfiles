return {
	{
		"vscode-neovim/vscode-multi-cursor.nvim",
		config = function()
			require("vscode-multi-cursor").setup({
				default_mappings = true,
				no_selection = false,
			})

			-- vscode-multi-cursor
			vim.keymap.set({ "n", "x" }, "mc", require("vscode-multi-cursor").create_cursor, { expr = true })
			vim.keymap.set({ "n" }, "mr", require("vscode-multi-cursor").cancel)
			vim.keymap.set({ "n", "x" }, "mi", require("vscode-multi-cursor").start_left)
			vim.keymap.set({ "n", "x" }, "ma", require("vscode-multi-cursor").start_right)
			vim.keymap.set({ "n" }, "mj", require("vscode-multi-cursor").next_cursor)
			vim.keymap.set({ "n" }, "mk", require("vscode-multi-cursor").prev_cursor)
			vim.keymap.set({ "x" }, "mh", function()
				require("vscode-multi-cursor").selectHighlights()
			end)
			vim.keymap.set({ "n" }, "mfc", require("vscode-multi-cursor").flash_char)
			vim.keymap.set({ "n" }, "mfw", require("vscode-multi-cursor").flash_word)
			vim.keymap.set("n", "<C-t>", "mciw*<Cmd>nohl<CR>", { remap = true })

			-- 'app-grid:nth-child(1) .rollout-block-container:nth-child(1)'
		end,
	},
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {
			highlight = { backdrop = false },
			modes = {
				search = {
					enabled = true,
					highlight = { backdrop = true },
				},
				char = {
					highlight = { backdrop = true },
				},
			},
		},
		keys = {
			-- { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
			-- { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
			-- { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
		},
	},
}
