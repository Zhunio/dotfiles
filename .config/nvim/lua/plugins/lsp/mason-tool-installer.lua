return {
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		opts = {
			ensure_installed = {
				-- bash
				"bashls",
				"shfmt",

				-- lua
				"lua_ls",
				"stylua",

				-- html, css, js
				"html",
				"cssls",
				"ts_ls",
				-- sass
				"some-sass-language-server",
				"js-debug-adapter",

				-- markdown
				"marksman",

				-- prettier
				"prettier",

				-- angular
				"angularls",

				-- java
				-- "java-test",
				-- "java-debug-adapter",
				-- "lombok-nightly",
				"jdtls",
				-- "google-java-format",

				-- python
				"pyright",
				"black",
				"isort",

				-- docker
				"docker-compose-language-service",
				"dockerfile-language-server",

				-- terraform
				"terraform-ls",

				-- SQL
				"sqlls",
				"sqlfmt",
			},
		},
	},
}
