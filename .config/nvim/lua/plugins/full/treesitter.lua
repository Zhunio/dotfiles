return {
	"nvim-treesitter/nvim-treesitter",
	branch = "master",
	build = ":TSUpdate",
	ft = { "octo" },
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("nvim-treesitter.configs").setup({
			auto_install = true,
			highlight = { enable = true, disable = { "json" }, additional_vim_regex_highlighting = false },
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
				"css",
				"diff",
				"go",
				"gitcommit",
				"gitignore",
				"html",
				"java",
				"javascript",
				"json",
				"lua",
				"luadoc",
				"markdown",
				"markdown_inline",
				"python",
				"query",
				"regex",
				"sql",
				"terraform",
				"tmux",
				"typescript",
				"vim",
				"vimdoc",
				"vue",
				"xml",
				"yaml",
			},
		})
		vim.treesitter.language.register("markdown", { "octo", "copilot-chat" })
		vim.treesitter.language.register("terraform", "hcl")
		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "octo", "copilot-chat", "markdown" },
			command = "TSBufEnable highlight",
		})
	end,
}
