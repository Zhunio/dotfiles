return {
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

			local function lua_ls()
				vim.lsp.config("lua_ls", {
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
			end

			local function terraformls()
				vim.lsp.config("terraformls", {
					on_attach = on_attach,
					cmd = { "terraform-ls", "serve" },
					filetypes = { "terraform", "terraform-vars" },
				})
			end

			local function angularls()
				local angularls_path = vim.fn.stdpath("data") .. "/mason/packages/angular-language-server"
				local cmd = {
					"ngserver",
					"--stdio",
					"--tsProbeLocations",
					angularls_path,
					"--ngProbeLocations",
					angularls_path .. "/node_modules/@angular/language-server",
				}

				vim.lsp.config("angularls", {
					cmd = cmd,
					on_attach = on_attach,
					on_new_config = function(new_config, new_root_dir)
						new_config.cmd = cmd
					end,
				})
			end

			-- TODO: Update this so that it does not get called by mason-lspconfig, instead it gets called by jdtls
			-- ["jdtls"] = function() end,

			local function bashls()
				vim.lsp.config("bashls", {
					cmd = { "bash-language-server", "start" },
					on_attach = on_attach,
					filetypes = { "sh", "bash", "zsh" },
				})
			end

			lua_ls()
			terraformls()
			angularls()
			bashls()

			require("mason-lspconfig").setup({})

			-- Change the Diagnostic symbols in the sign column (gutter)
			local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
			end
		end,
	},
}
