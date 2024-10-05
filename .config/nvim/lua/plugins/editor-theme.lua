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
}
