return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
    lazy = true,
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				transparent_background = true,
				integrations = {
					diffview = true,
				},
				highlight_overrides = {
					mocha = function(mocha)
						return {
							sqlKeyword = { link = "Statement" },
							yamlBlockMappingKey = { fg = mocha.lavender },
							yamlPlainScalar = { fg = mocha.green },
							typescriptImport = { link = "Keyword" },
							typescriptVariable = { link = "Keyword" },
							typescriptExport = { link = "Keyword" },
							htmlTag = { link = "Function" },
							htmlTagN = { link = "Function" },
							htmlTagName = { link = "Function" },
							javaCommentTitle = { link = "Comment" },
							javaExternal = { fg = mocha.mauve, style = { "italic" } },
							["@lsp.type.class.java"] = { fg = mocha.yellow, style = { "italic" } },
							["@lsp.type.namespace.java"] = { fg = mocha.yellow },
							["@lsp.type.annotation.java"] = { fg = mocha.peach },
							["@lsp.type.method.java"] = { fg = mocha.blue, style = { "italic" } },
							["@lsp.mod.static.java"] = { fg = mocha.peach },
							["@lsp.type.property.java"] = { fg = mocha.text },
							["@lsp.type.enumMember.java"] = { fg = mocha.teal },
						}
					end,
				},
			})
			vim.cmd("colorscheme catppuccin-mocha")
		end,
	},
	-- {
	--   "olimorris/onedarkpro.nvim",
	--   priority = 1000,
	--   config = function()
	--     require("onedarkpro").setup({
	--       styles = {
	--         comments = "italic",
	--         keywords = "bold"
	--       },
	--       options = {
	--         transparency = true,
	--       },
	--       highlights = {
	--         -- purple
	--         ["Function"] = { link = "Keyword" },
	--         ["typescriptImport"] = { link = "Keyword" },
	--         ["typescriptExport"] = { link = "Keyword" },
	--         ["typescriptIdentifier"] = { link = "Keyword" },
	--         ["typescriptVariable"] = { link = "Keyword" },
	--         ["typescriptCastKeyword"] = { link = "Keyword" },
	--         -- red
	--         ["Identifier"] = { fg = "${red}", bold = true },
	--         ["typescriptBlock"] = { link = "Identifier" },
	--         ["typescriptMember"] = { link = "Identifier" },
	--         ["@lsp.type.property.typescript"] = { link = "Identifier" },
	--         ["@lsp.mod.readonly.typescript"] = { link = "Identifier" },
	--         -- green
	--         ["typescriptString"] = { fg = "${green}", bold = true },
	--         -- blue
	--         ["typescriptFuncName"] = { fg = "${blue}", bold = true },
	--         ["@lsp.type.function.typescript"] = { link = "typescriptFuncName" },
	--         ["@lsp.type.member.typescript"] = { link = "typescriptFuncName" },
	--         ["@lsp.type.method.lua"] = { link = "typescriptFuncName" },
	--         -- yellow
	--         ["typescriptCall"] = { fg = "${yellow}", bold = true },
	--         ["typescriptPredefinedType"] = { link = "typescriptCall" },
	--         ["@lsp.type.parameter.typescript"] = { link = "typescriptCall" },
	--         ["@lsp.type.interface.typescript"] = { link = "typescriptCall" },
	--         ["@lsp.type.class.typescript"] = { link = "typescriptCall" },
	--         -- other color
	--         ["@lsp.type.variable.typescript"] = { link = "@constant" },
	--         ["@variable"] = { link = "@constant" },
	--       },
	--     })
	--     vim.cmd("colorscheme onedark")
	--   end,
	-- },
}
