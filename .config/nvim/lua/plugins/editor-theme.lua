return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
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
				["@lsp.type.interface"] = { fg = C.yellow },
				-- Typescript
				typescriptTry = { link = "Exception" },
				typescriptExceptions = { link = "Exception" },
				typescriptNull = { link = "Keyword" },
				typescriptVariable = { link = "Keyword" },
				typescriptPredefinedType = { link = "Keyword" },
				typescriptOperator = { link = "Keyword" },
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
