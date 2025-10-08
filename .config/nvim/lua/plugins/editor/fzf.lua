return {
	{
		"ibhagwan/fzf-lua",
		cmd = { "FzfLua" },
    -- stylua: ignore
		keys = {
			-- File operations
			{ "<leader>ff", function() require('fzf-lua').files() end, desc = "Fzf: Search and open files" },
			{ "<leader>fh", function() require("fzf-lua").helptags() end, desc = "Fzf: Search Neovim help tags" },
			{ "<leader>fq", function() require("fzf-lua").quickfix() end, desc = "Fzf: Show quickfix list" },

			-- Search
			{ "<leader>fg", function() require('fzf-lua').live_grep() end, desc = "Fzf: Search text in project (live grep)" },
			{ "<leader>f?", function() require('fzf-lua').lgrep_curbuf() end, desc = "Fzf: Search text in current buffer" },

      -- Git integration
			{ "<leader>fb", function() require("fzf-lua").git_branches() end, desc = "Fzf: List and checkout git branches" },

      -- LSP (Language Server Protocol)
			{ "gr", function() require("fzf-lua").lsp_references() end, desc = "Fzf: Find references to symbol under cursor" },
			{ "gd", function() require("fzf-lua").lsp_definitions() end, desc = "Fzf: Go to definition of symbol under cursor" },
			{ "gD", function() vim.diagnostic.enable(not vim.diagnostic.is_enabled()) end, desc = "Toggle diagnostics display" },
			{ "g=", function() require('fzf-lua').lsp_code_actions() end, desc = "Fzf: Show available code actions" },
			{ "<leader>f@", function() require("fzf-lua").lsp_document_symbols() end, desc = "Fzf: List symbols in current document" },
			{ "<leader>f#", function() require("fzf-lua").lsp_live_workspace_symbols() end, desc = "Fzf: Search symbols in workspace" },
			{ "<leader>fd", function() require("fzf-lua").diagnostics_document() end, desc = "Fzf: Show diagnostics for current document" },

      -- Miscellaneous
			{ "<leader>fp", function() require("fzf-lua").commands() end, desc = "Fzf: List available commands" },
			{ "<leader>f:", function() require("fzf-lua").command_history() end, desc = "Fzf: Show command history" },
			{ "<leader>fk", function() require("fzf-lua").keymaps() end, desc = "Fzf: List keymaps" },
			{ "<leader>fr", function() require("fzf-lua").registers() end, desc = "Fzf: Show registers" },
		},
		config = function()
			require("fzf-lua").setup({
				lsp = {
					symbols = {
						symbol_style = 2,
						symbol_fmt = function(s)
							return s
						end,
						symbol_icons = {
							Text = "󰉿",
							Method = "󰆧",
							Function = "󰆧",
							Constructor = "󰆧",
							Field = "",
							Variable = "",
							Class = "",
							Interface = "",
							Module = "󰅩",
							Property = "",
							Unit = "󰑭",
							Value = "",
							Enum = "",
							Keyword = "󰌋",
							Snippet = "",
							Color = "",
							File = "󰈙",
							Reference = "",
							Folder = "",
							EnumMember = "",
							Constant = "",
							Struct = "",
							Event = "",
							Operator = "",
							TypeParameter = "",
						},
					},
				},
			})

			vim.cmd([[FzfLua register_ui_select]])
		end,
	},
}
