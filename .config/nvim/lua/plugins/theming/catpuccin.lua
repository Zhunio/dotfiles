return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			local backgroung = "#011627"

			-- rosewater = "#f5e0dc",
			-- flamingo = "#f2cdcd",
			-- pink = "#f5c2e7",
			-- mauve = "#cba6f7",
			-- red = "#f38ba8",
			-- maroon = "#eba0ac",
			-- peach = "#fab387",
			-- yellow = "#f9e2af",
			-- green = "#a6e3a1",
			-- teal = "#94e2d5",
			-- sky = "#89dceb",
			-- sapphire = "#74c7ec",
			-- blue = "#89b4fa",
			-- lavender = "#b4befe",
			-- text = "#cdd6f4",
			-- subtext1 = "#bac2de",
			-- subtext0 = "#a6adc8",
			-- overlay2 = "#9399b2",
			-- overlay1 = "#7f849c",
			-- overlay0 = "#6c7086",
			-- surface2 = "#585b70",
			-- surface1 = "#45475a",
			-- surface0 = "#313244",
			-- base = "#1e1e2e",
			-- mantle = "#181825",
			-- crust = "#11111b",
			local C = require("catppuccin.palettes").get_palette("mocha")

			local custom_highlights = {
				-- Default
				Constant = { fg = C.teal },
				Label = { fg = C.mauve },
				Operator = { fg = C.peach },
				Exception = { fg = C.mauve },
				Structure = { fg = C.mauve },
				Special = { fg = C.mauve },
				-- lsp
				["@property"] = { fg = C.text },
				["@module"] = { fg = C.yellow },
				["@variable.member"] = { fg = C.text },
				["@lsp.type.interface"] = { fg = C.yellow },
				-- Typescript
				typescriptTry = { link = "Exception" },
				typescriptExceptions = { link = "Exception" },
				typescriptNull = { link = "Keyword" },
				typescriptVariable = { link = "Keyword" },
				typescriptPredefinedType = { link = "Keyword" },
				typescriptOperator = { link = "Keyword" },
				typescriptEnumKeyword = { link = "Keyword" },
				typescriptMethodAccessor = { link = "Keyword" },
				["@lsp.type.member.typescript"] = { link = "Function" },
				-- HTML
				htmlTag = { fg = C.blue },
				htmlTagN = { link = "htmlTag" },
				htmlTagName = { link = "htmlTag" },
				-- SASS
				sassMixing = { link = "Keyword" },
				sassMixinName = { link = "Function" },
				-- CSS
				cssFontAttr = { fg = C.text },
				cssTextAttr = { fg = C.text },
				cssPositioningAttr = { fg = C.text },
				cssFlexibleBoxAttr = { fg = C.text },
				-- Java
				["@lsp.type.annotation.java"] = { fg = C.peach },
				["@lsp.type.property.java"] = { fg = C.peach },
				-- SQL
				sqlType = { link = "Keyword" },
				-- YAML
				yamlBlockMappingKey = { fg = C.blue },
				yamlPlainScalar = { fg = C.green },
				-- Terraform
				["@lsp.type.type.terraform"] = { link = "Keyword" },
				["@lsp.type.parameter.terraform"] = { fg = C.text },
				["@lsp.type.enumMember.terraform"] = { fg = C.red },
				["@variable.member.terraform"] = { fg = C.teal },
				-- Alpha
				AlphaHeader = { fg = C.peach },
				AlphaGroupTitle = { fg = C.peach },
				AlphaButton = { fg = C.text },
				AlphaButtonShortcut = { fg = C.mauve, style = { "bold" } },
				-- Neogit
				NeogitDiffHeader = { bg = backgroung },
				NeogitDiffContext = { bg = backgroung },
				NeogitDiffAdd = { bg = backgroung },
				NeogitDiffDelete = { bg = backgroung },
				NeogitHunkHeader = { bg = backgroung },
				NeogitActiveItem = { bg = backgroung },
				NeogitHunkHeaderHighlight = { fg = C.surface0, bg = C.mauve, style = { "bold" } },
				NeogitDiffContextHighlight = { bg = backgroung },
				NeogitDiffAddHighlight = { bg = backgroung },
				NeogitDiffDeleteHighlight = { bg = backgroung },
				-- Markdown
				RenderMarkdownCode = { bg = backgroung },
				RenderMarkdownCodeInline = { bg = backgroung },
				-- VimFlog
				flogHash = { fg = C.mauve },
				flogDate = { fg = C.peach },
				flogAuthor = { fg = C.maroon },
				flogRef = { fg = "Orange1" },
				flogRefRemote = { link = "flogRef" },
				flogRefTag = { link = "flogRef" },
				flogRefHead = { fg = "Green1" },
				flogRefHeadArrow = { link = "flogRefHead" },
				flogRefHeadBranch = { link = "flogRefHead" },
				-- FzfLua
				FzfLuaNormal = { bg = backgroung },
			}

			require("catppuccin").setup({
				transparent_background = true,
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
