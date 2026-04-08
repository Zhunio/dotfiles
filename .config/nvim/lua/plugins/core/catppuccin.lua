return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			local background = "#011627"
			local panel_background = "#0b253a"
			local border = "#5f7e97"
			local focus_border = "#122d42"
			local selection_background = "#1d3b53"
			local line_highlight = panel_background
			local C = require("catppuccin.palettes").get_palette("mocha")

			local custom_highlights = {
				-- Default
				Normal = { bg = background },
				NormalNC = { bg = background },
				SignColumn = { bg = background },
				EndOfBuffer = { bg = background },
				CursorLine = { bg = line_highlight },
				CursorColumn = { bg = line_highlight },
				CursorLineNr = { fg = C.text },
				LineNr = { fg = border },
				Visual = { bg = selection_background },
				Search = { bg = selection_background },
				IncSearch = { fg = background, bg = C.yellow },
				Constant = { fg = C.teal },
				String = { fg = C.green },
				Character = { fg = C.green },
				Number = { fg = C.teal },
				Boolean = { fg = C.teal },
				Float = { fg = C.teal },
				Function = { fg = C.blue },
				Identifier = { fg = C.text },
				Label = { fg = C.mauve },
				Keyword = { fg = C.mauve },
				Conditional = { fg = C.mauve },
				Repeat = { fg = C.mauve },
				Operator = { fg = C.peach },
				Exception = { fg = C.mauve },
				Structure = { fg = C.mauve },
				Special = { fg = C.mauve },
				NormalFloat = { bg = panel_background },
				FloatBorder = { fg = border, bg = panel_background },
				FloatTitle = { fg = C.text, bg = panel_background },
				Pmenu = { bg = panel_background },
				PmenuSel = { bg = selection_background },
				PmenuSbar = { bg = panel_background },
				PmenuThumb = { bg = border },
				WinSeparator = { fg = focus_border, bg = background },
				VertSplit = { fg = focus_border, bg = background },
				-- Treesitter
				["@keyword"] = { fg = C.mauve },
				["@keyword.return"] = { fg = C.mauve },
				["@keyword.function"] = { fg = C.mauve },
				["@keyword.conditional"] = { fg = C.mauve },
				["@keyword.repeat"] = { fg = C.mauve },
				["@constant"] = { fg = C.teal },
				["@constant.builtin"] = { fg = C.teal },
				["@string"] = { fg = C.green },
				["@string.escape"] = { fg = C.peach },
				["@function"] = { fg = C.blue },
				["@function.call"] = { fg = C.blue },
				["@function.method"] = { fg = C.blue },
				["@function.method.call"] = { fg = C.blue },
				["@method"] = { fg = C.blue },
				["@method.call"] = { fg = C.blue },
				["@property"] = { fg = C.text },
				["@module"] = { fg = C.yellow },
				["@variable.member"] = { fg = C.text },
				-- LSP semantic tokens
				["@lsp.type.keyword"] = { fg = C.mauve },
				["@lsp.type.function"] = { fg = C.blue },
				["@lsp.type.method"] = { fg = C.blue },
				["@lsp.type.enumMember"] = { fg = C.teal },
				["@lsp.type.interface"] = { fg = C.yellow },
				-- Neogit
				NeogitDiffHeader = { bg = background },
				NeogitDiffContext = { bg = background },
				NeogitDiffAdd = { bg = background },
				NeogitDiffDelete = { bg = background },
				NeogitHunkHeader = { bg = background },
				NeogitActiveItem = { bg = background },
				NeogitHunkHeaderHighlight = { fg = C.surface0, bg = C.mauve, style = { "bold" } },
				NeogitDiffContextHighlight = { bg = background },
				NeogitDiffAddHighlight = { bg = background },
				NeogitDiffDeleteHighlight = { bg = background },
				-- FzfLua
				FzfLuaNormal = { bg = background },
				FzfLuaBorder = { bg = background },
			}

			require("catppuccin").setup({
				transparent_background = false,
				color_overrides = {
					mocha = {
						base = background,
						mantle = panel_background,
					},
				},
				integrations = {
					diffview = true,
				},
				custom_highlights = custom_highlights,
			})

			vim.cmd("colorscheme catppuccin-mocha")
			vim.cmd("set cmdheight=1")
		end,
	},
}
