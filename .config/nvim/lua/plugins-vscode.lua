return {
	{
		"vscode-neovim/vscode-multi-cursor.nvim",
		config = function()
			local multi_cursor = require("vscode-multi-cursor")

			multi_cursor.setup({
				default_mappings = true,
				no_selection = false,
			})

			vim.keymap.set({ "n", "x" }, "mc", multi_cursor.create_cursor, { expr = true })
			vim.keymap.set({ "n" }, "mr", multi_cursor.cancel)
			vim.keymap.set({ "n", "x" }, "mi", multi_cursor.start_left)
			vim.keymap.set({ "n", "x" }, "ma", multi_cursor.start_right)
			vim.keymap.set({ "n" }, "mj", multi_cursor.next_cursor)
			vim.keymap.set({ "n" }, "mk", multi_cursor.prev_cursor)
      --stylua: ignore
			vim.keymap.set({ "n" }, "mh", "viw<Cmd>lua require('vscode-multi-cursor').selectHighlights()<CR>")
			vim.keymap.set({ "x" }, "mh", function() multi_cursor.selectHighlights() end)
			vim.keymap.set({ "n" }, "mfc", multi_cursor.flash_char)
			vim.keymap.set({ "n" }, "mfw", multi_cursor.flash_word)
			vim.keymap.set("n", "<C-t>", "mciw*<Cmd>nohl<CR>", { remap = true })
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
					highlight = { backdrop = false },
				},
				char = {
					highlight = { backdrop = false },
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
