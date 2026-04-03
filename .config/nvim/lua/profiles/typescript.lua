local with_plugin = require("config.with-plugin")

local function get_vue_ts_plugin_location()
	local vue_language_server_path = vim.fs.joinpath(vim.fn.stdpath("data"), "mason", "packages", "vue-language-server")
	if not vim.uv.fs_stat(vue_language_server_path) then
		return nil
	end

	return vim.fs.joinpath(vue_language_server_path, "node_modules", "@vue", "language-server")
end

local vue_ts_plugin_location = get_vue_ts_plugin_location()

return {
	require("plugins.shared.nvim-cmp"),
	require("plugins.shared.treesitter"),
	require("plugins.shared.octo"),
	with_plugin("plugins.shared.conform", {
		opts = {
			formatters_by_ft = {
				javascript = { "prettier" },
				typescript = { "prettier" },
				json = { "prettier" },
				yaml = { "prettier" },
				markdown = { "prettier" },
			},
		},
	}),
	with_plugin("plugins.shared.mason-tool-installer", {
		opts = {
			ensure_installed = { "ts_ls", "js-debug-adapter", "prettier" },
		},
	}),
	with_plugin("plugins.shared.mason-lspconfig", {
		config = function()
			local on_attach = require("config.on_attach")
			vim.lsp.config("ts_ls", vim.tbl_deep_extend("force", { on_attach = on_attach }, {
				cmd = { "typescript-language-server", "--stdio" },
				on_attach = function(_, bufnr)
					on_attach(_, bufnr)
					vim.keymap.set("n", "gO", function()
						vim.lsp.buf.execute_command({
							command = "_typescript.organizeImports",
							arguments = { vim.api.nvim_buf_get_name(bufnr) },
						})
					end, { buffer = bufnr, desc = "LSP: Organize Imports" })
				end,
				filetypes = {
					"javascript",
					"javascriptreact",
					"javascript.jsx",
					"typescript",
					"typescriptreact",
					"typescript.tsx",
					"vue",
				},
				init_options = {
					plugins = vue_ts_plugin_location and {
						{
							name = "@vue/typescript-plugin",
							location = vue_ts_plugin_location,
							languages = { "vue" },
						},
					} or {},
				},
			}))

			require("mason-lspconfig").setup({})
		end,
	}),
}
