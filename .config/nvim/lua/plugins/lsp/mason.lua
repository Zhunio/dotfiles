return {
	{
		"williamboman/mason.nvim",
		opts = {
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		},
	},
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
				"google-java-format",

				-- python
				"pyright",
				"black",
				"isort",

				-- docker
				"docker-compose-language-service",
				"dockerfile-language-server",

				-- SQL
				"sqlls",
				"sqlfmt",
			},
		},
	},
	{
		"williamboman/mason-lspconfig.nvim",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			"neovim/nvim-lspconfig",
		},
		config = function()
			local on_attach = function()
				vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, {})
				vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			end

			require("mason-lspconfig").setup_handlers({
				function(server_name)
					require("lspconfig")[server_name].setup({
						on_attach = on_attach,
					})
				end,
				["angularls"] = function()
					local angularls_path =
						require("mason-registry").get_package("angular-language-server"):get_install_path()

					local cmd = {
						"ngserver",
						"--stdio",
						"--tsProbeLocations",
						angularls_path,
						"--ngProbeLocations",
						angularls_path .. "/node_modules/@angular/language-server",
					}

					require("lspconfig").angularls.setup({
						cmd = cmd,
						on_new_config = function(new_config, new_root_dir)
							new_config.cmd = cmd
						end,
					})
				end,
				["jdtls"] = function() end,
				["bashls"] = function()
					require("lspconfig")["bashls"].setup({
						cmd = { "bash-language-server", "start" },
						on_attach = on_attach,
						filetypes = { "sh", "bash", "zsh" },
					})
				end,
				["lua_ls"] = function()
					require("lspconfig")["lua_ls"].setup({
						on_attach = on_attach,
						settings = {
							Lua = {
								workspace = {
									library = { vim.env.VIMRUNTIME },
								},
								diagnostics = {
									globals = { "vim" },
								},
								completion = {
									callSnippet = "Replace",
								},
							},
						},
					})
				end,
			})

			-- Change the Diagnostic symbols in the sign column (gutter)
			local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
			end
		end,
	},
}
