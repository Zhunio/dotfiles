return {
	{
		"williamboman/mason.nvim",
    event = { 'BufReadPost', 'BufNewFile' },
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

			local ensure_installed_servers = { "lua_ls", "html", "cssls", "ts_ls", "angularls", "jdtls" }
			require("mason-lspconfig").setup({
				ensure_installed = ensure_installed_servers,
				automatic_installation = true,
			})

			for _, server in ipairs(ensure_installed_servers) do
				local lsp_config = require("lspconfig")
				lsp_config[server].setup({
					on_attach = function()
						vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, {})
						vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
						vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
						vim.keymap.set("n", "g=", vim.lsp.buf.code_action, {})

						local builtin = require("telescope.builtin")
						vim.keymap.set("n", "gr", builtin.lsp_references, {})
					end,
				})
			end

			-- Typescript organize imports
			vim.keymap.set("n", "<leader>o", function()
				vim.lsp.buf.execute_command({
					command = "_typescript.organizeImports",
					arguments = { vim.api.nvim_buf_get_name(0) },
					title = "Organize Imports",
				})
			end)

			-- Change the Diagnostic symbols in the sign column (gutter)
			local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
			end

			-- toggle diagnostics
			vim.keymap.set("n", "<leader>dd", function()
				vim.diagnostic.enable(not vim.diagnostic.is_enabled())
			end)
		end,
	},
}
