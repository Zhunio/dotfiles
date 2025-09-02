local Preview = {
	hidden = { hidden = true },
	short = { vertical = "up:40%" },
}

return {
	{
		"ibhagwan/fzf-lua",
		cmd = { "FzfLua" },
    -- stylua: ignore
		keys = {
			-- Buffers & Files
			{ "<leader>ff", function() require('fzf-lua').files() end },
			{ "<leader>fh", function() require("fzf-lua").highlights({ winopts = { preview = Preview.short } }) end },
			{ "<leader>fq", function() require("fzf-lua").quickfix({ winopts = { preview = Preview.short } }) end },

			-- Search
			{ "<leader>fg", function() require('fzf-lua').live_grep({ winopts = { preview = Preview.short } }) end },
			{ "<leader>f?", function() require('fzf-lua').lgrep_curbuf({ winopts = { preview = Preview.short } }) end },

      -- Git
			{ "<leader>fb", function() require("fzf-lua").git_branches({ winopts = { preview = Preview.hidden } }) end },

      -- LSP
			{ "gr", function() require("fzf-lua").lsp_references() end },
			{ "gd", function() require("fzf-lua").lsp_definitions() end },
			{ "gD", function() vim.diagnostic.enable(not vim.diagnostic.is_enabled()) end },
			{ "g=", function() require('fzf-lua').lsp_code_actions() end },
			{ "<leader>f@", function() require("fzf-lua").lsp_document_symbols({ winopts = { preview = Preview.short } }) end },
			{ "<leader>f#", function() require("fzf-lua").lsp_live_workspace_symbols({ winopts = { preview = Preview.short } }) end },
			{ "<leader>fd", function() require("fzf-lua").diagnostics_document({ winopts = { preview = Preview.short } }) end, },

      -- Misc
			{ "<leader>fp", function() require("fzf-lua").commands({ winopts = { preview = Preview.hidden } }) end, },
			{ "<leader>f:", function() require("fzf-lua").command_history({ winopts = { preview = Preview.hidden } }) end, },
			{ "<leader>fk", function() require("fzf-lua").keymaps({ winopts = { preview = Preview.hidden } }) end, },
			{ "<leader>fr", function() require("fzf-lua").registers({ winopts = { preview = Preview.hidden } }) end, },

		},
		opts = {
			winopts = {
				fullscreen = true,

				border = "none",
				preview = {
					border = "none",
					layout = "vertical",
					vertical = "up:80%",
				},
			},
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
		},
	},
}
