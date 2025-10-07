local on_attach = require("config.lsp.on_attach")

return {
	on_attach = function(client, bufnr)
		on_attach()

		for _, other_client in pairs(vim.lsp.get_clients({ bufnr = bufnr })) do
			if other_client.name == "ts_ls" then
				vim.lsp.stop_client(other_client.id)
			end
		end
	end,
}
