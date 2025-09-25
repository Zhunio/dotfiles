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

				-- html
				"html",

				-- emmet
				"emmet_language_server",

				-- css
				"cssls",

				-- typescript
				"ts_ls",
				"js-debug-adapter",

				-- sass
				"some-sass-language-server",

				-- markdown
				"marksman",

				-- prettier
				"prettier",

				-- angular
				"angularls",

				-- java
				"java-test",
				"java-debug-adapter",
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
				-- "terraform-ls",

				-- SQL
				"sqlls",
				"sqlfmt",
			},
		},
	},
}
