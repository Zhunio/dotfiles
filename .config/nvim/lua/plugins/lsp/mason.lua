return {
	"williamboman/mason.nvim",
	event = { "BufReadPost", "BufNewFile" },
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
	},
	config = function()
		require("mason").setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		local mason_lspconfig = require("mason-lspconfig")
		local lspconfig = require("lspconfig")

		local ensure_installed_servers = { "lua_ls", "html", "cssls", "ts_ls", "angularls", "jdtls" }

		mason_lspconfig.setup({
			ensure_installed = ensure_installed_servers,
			automatic_installation = true,
		})

		local on_attach = function()
			vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, {})
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
      --stylua: ignore
      vim.keymap.set("n", "gD", function() vim.diagnostic.enable(not vim.diagnostic.is_enabled()) end)
			vim.keymap.set("n", "g=", vim.lsp.buf.code_action, {})
      --stylua: ignore
      vim.keymap.set("n", "gr", function() require("telescope.builtin").lsp_references({ fname_width = 50 }) end, {})
		end

		mason_lspconfig.setup_handlers({
			function(server_name)
				lspconfig[server_name].setup({ on_attach = on_attach })
			end,
			["lua_ls"] = function()
				lspconfig["lua_ls"].setup({
					on_attach = on_attach,
					settings = {
						Lua = {
              workspace = {
                library = { vim.env.VIMRUNTIME }
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
}
