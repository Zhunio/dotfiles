return {
	"mfussenegger/nvim-jdtls",
	ft = "java",
	dependencies = {
		{ "microsoft/vscode-java-test", build = "npm install && npm run build-plugin" },
	},
	-- "nvim-java/nvim-java",
	-- ft = "java",
	-- dependencies = {
	-- 	"neovim/nvim-lspconfig",
	-- },
	-- config = function()
	-- 	local on_attach = function()
	-- 		vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, {})
	-- 		vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
	-- 		vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
	--      --stylua: ignore
	--      vim.keymap.set("n", "gD", function() vim.diagnostic.enable(not vim.diagnostic.is_enabled()) end)
	-- 		vim.keymap.set("n", "g=", vim.lsp.buf.code_action, {})
	--      --stylua: ignore
	--      vim.keymap.set("n", "gr", function() require("telescope.builtin").lsp_references({ fname_width = 50 }) end, {})
	-- 	end
	--
	-- 	require("java").setup({
	-- 		java_test = { enable = false },
	-- 		java_debug_adapter = { enable = false },
	-- 		jdk = { auto_install = false },
	-- 	})
	--
	-- 	local lspconfig = require("lspconfig")
	-- 	lspconfig["jdtls"].setup({
	-- 		on_attach = on_attach,
	-- 	})
	-- end,
}
