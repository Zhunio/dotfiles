return {
	{
		"nvim-telescope/telescope.nvim",
		event = "VeryLazy",
		tag = "0.1.5",
    --stylua: ignore
    keys = {
      { "<leader>ff", require('telescope.builtin').find_files },
      { "<leader>fp", require('telescope.builtin').commands },
      { "<leader>fd", require('telescope.builtin').diagnostics },
      { "<leader>f@", function() require('telescope.builtin').lsp_document_symbols({ symbol_width = 100 }) end },
      { "<leader>t", require('telescope.builtin').buffers },
      { "<leader>fh", require('telescope.builtin').highlights },

      { "<leader>fg", require('telescope.builtin').live_grep },
      { "<leader>f?", require('telescope.builtin').current_buffer_fuzzy_find },

      { "<leader>fb", require('telescope.builtin').git_branches },

      { "<leader>fr", require('telescope.builtin').registers },
      { "<leader>fq", function() require('telescope.builtin').quickfix({ fname_width = 50 }) end },
      { '<leader>f:', require('telescope.builtin').command_history }
    },
		config = function()
			local C = require("catppuccin.palettes").get_palette("mocha")
			vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = C.green })
			vim.api.nvim_set_hl(0, "TelescopeSelection", { fg = C.green })
			vim.api.nvim_set_hl(0, "TelescopeSelectionCaret", { fg = C.green })
			vim.api.nvim_set_hl(0, "TelescopeMultiIcon", { fg = C.green })
			vim.api.nvim_set_hl(0, "TelescopePromptPrefix", { fg = C.green })
			vim.api.nvim_set_hl(0, "TelescopeResultsIdentifier", { fg = C.text })

			local pickers = {}

			-- short pickers
			for _, picker in ipairs({ "git_branches", "find_files", "buffers" }) do
				pickers[picker] = {
					layout_config = {
						preview_height = 0.70,
					},
				}
			end

			-- tall pickers
			for _, picker in ipairs({
				"commands",
				"diagnostics",
				"lsp_document_symbols",
				"live_grep",
				"current_buffer_fuzzy_find",
				"registers",
				"quickfix",
			}) do
				pickers[picker] = {
					layout_config = {
						preview_height = 0.20,
					},
				}
			end

			require("telescope").setup({
				defaults = {
					path_display = { "tail" },
					prompt_prefix = " ",
					selection_caret = " ",
					multi_icon = " ",
					borderchars = { "─", " ", " ", " ", " ", " ", " ", " " },
					layout_strategy = "vertical",
					layout_config = {
						width = 0.99,
						height = 0.99,
						preview_cutoff = 0,
					},
				},
				pickers = pickers,
			})
		end,
	},
}