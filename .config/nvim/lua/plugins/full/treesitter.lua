local function executable(bin)
	return vim.fn.executable(bin) == 1
end

return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	enabled = function()
		return executable("tree-sitter")
	end,
	config = function()
		local ensure_installed = {
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
		}

		require("nvim-treesitter").setup({
			install_dir = vim.fn.stdpath("data") .. "/nvim-treesitter",
		})

		require("nvim-treesitter").install(ensure_installed)

		vim.treesitter.language.register("markdown", { "octo", "copilot-chat" })
		vim.treesitter.language.register("terraform", "hcl")

		vim.api.nvim_create_autocmd("FileType", {
			pattern = ensure_installed,
			callback = function()
				vim.treesitter.start()
			end,
		})
	end,
}
