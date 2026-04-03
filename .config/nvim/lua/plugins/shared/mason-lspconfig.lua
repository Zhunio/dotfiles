return {
	"williamboman/mason-lspconfig.nvim",
	event = { "BufReadPost", "BufNewFile" },
	dependencies = { "neovim/nvim-lspconfig" },
	config = function()
		local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		vim.diagnostic.config({ virtual_text = true })
		require("mason-lspconfig").setup({})
	end,
}
