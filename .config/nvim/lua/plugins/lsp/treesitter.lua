return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		ft = { "octo" },
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("nvim-treesitter.configs").setup({
				auto_install = true,
				highlight = {
					enable = true,
					disable = { "json", "typescript" },
					additional_vim_regex_highlighting = false,
				},
				indent = { enable = true },
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<C-Space>",
						node_incremental = "<C-Space>",
						scope_incremental = false,
						node_decremental = "<bs>",
					},
				},
				ensure_installed = {
					"bash",
					"c",
					"css",
					"csv",
					"c_sharp",
					"diff",
					"dockerfile",
					"editorconfig",
					"gitcommit",
					"gitignore",
					"html",
					"http",
					"java",
					"javascript",
					"jq",
					"json",
					"lua",
					"luadoc",
					"markdown",
					"markdown_inline",
					"prisma",
					"python",
					"query",
					"regex",
					"sql",
					"ssh_config",
					"terraform",
					"tmux",
					"typescript",
					"vim",
					"vimdoc",
					"yaml",
					"xml",
				},
			})

			vim.treesitter.language.register("markdown", { "octo", "copilot-chat" })

			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "octo", "copilot-chat", "markdown" },
				command = "TSBufEnable highlight",
			})
		end,
	},
}
