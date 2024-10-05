return {
	"stevearc/conform.nvim",
  -- stylua: ignore
	keys = {
		{ "<leader>f", function() require("conform").format({ lsp_fallback = true, async = false, timeout_ms = 500 }) end },
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
			},
		})
	end,
}
