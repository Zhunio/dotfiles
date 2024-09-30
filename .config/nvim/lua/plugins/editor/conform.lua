return {
	{
		"stevearc/conform.nvim",
  -- stylua: ignore
    keys = {
      { "gf", function() require("conform").format() end },
    },
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
					javascript = { "prettier" },
					typescript = { "prettier" },
					css = { "prettier" },
					html = { "prettier" },
					json = { "prettier" },
					yaml = { "prettier" },
					markdown = { "prettier" },
					sh = { "shfmt" },
					bash = { "shfmt" },
					zsh = { "shfmt" },
					sql = { "sqlfmt" },
				},
			})
		end,
	},
}
