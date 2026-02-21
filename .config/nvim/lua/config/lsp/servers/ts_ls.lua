local on_attach = require("config.lsp.on_attach")

local function get_vue_ts_plugin_location()
	local vue_language_server_path = vim.fs.joinpath(vim.fn.stdpath("data"), "mason", "packages", "vue-language-server")
	if not vim.uv.fs_stat(vue_language_server_path) then
		return nil
	end

	return vim.fs.joinpath(vue_language_server_path, "node_modules", "@vue", "language-server")
end

local vue_ts_plugin_location = get_vue_ts_plugin_location()

return {
	cmd = { "typescript-language-server", "--stdio" },
	on_attach = function(client, bufnr)
		on_attach(client, bufnr)

		vim.keymap.set("n", "gO", function()
			vim.lsp.buf.execute_command({
				command = "_typescript.organizeImports",
				arguments = { vim.api.nvim_buf_get_name(bufnr) },
			})
		end, { desc = "LSP: Organize Imports" })
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
}
