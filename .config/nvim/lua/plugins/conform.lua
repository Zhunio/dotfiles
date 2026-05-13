return {
	"stevearc/conform.nvim",
	keys = {
		{ "gf", function() require("conform").format() end },
	},
	opts = {
		formatters_by_ft = {
			css = { "prettier" },
			html = { "prettier" },
			javascript = { "prettier" },
			java = { "google-java-format" },
			json = { "prettier" },
			lua = { "stylua" },
			markdown = { "prettier" },
			python = { "black" },
			scss = { "prettier" },
			typescript = { "prettier" },
			xml = { "xmlformatter" },
			yaml = { "prettier" },
		},
	},
}
