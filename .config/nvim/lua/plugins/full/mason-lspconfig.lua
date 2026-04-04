local function get_jdtls_config_path()
	local system = vim.loop.os_uname().sysname
	local config_dir = ({
		Darwin = "config_mac",
		Linux = "config_linux",
		Windows_NT = "config_win",
	})[system] or "config_linux"

	return vim.fn.glob("$MASON/packages/jdtls/" .. config_dir)
end

local function get_jdtls_config()
	local lombok_path = vim.fn.glob("$MASON/packages/jdtls/lombok.jar")
	local equinox_path = vim.fn.glob("$MASON/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar")
	local config_path = get_jdtls_config_path()
	local data_path = vim.fn.stdpath("cache") .. "/jdtls-data/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
	local bundles = vim.tbl_flatten({
		vim.fn.glob("$MASON/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar", nil, true),
		vim.fn.glob("$MASON/packages/java-test/extension/server/*.jar", nil, true),
	})
	local excluded_bundles = {
		"com.microsoft.java.test.runner-jar-with-dependencies.jar",
		"jacocoagent.jar",
	}

	for i = #bundles, 1, -1 do
		local filename = vim.fn.fnamemodify(bundles[i], ":t")
		if vim.tbl_contains(excluded_bundles, filename) then
			table.remove(bundles, i)
		end
	end

	return {
		cmd = {
			"java",
			"-Declipse.application=org.eclipse.jdt.ls.core.id1",
			"-Dosgi.bundles.defaultStartLevel=4",
			"-Declipse.product=org.eclipse.jdt.ls.core.product",
			"-Dlog.protocol=true",
			"-Dlog.level=ALL",
			"-javaagent:" .. lombok_path,
			"-Xmx1g",
			"--add-modules=ALL-SYSTEM",
			"--add-opens", "java.base/java.util=ALL-UNNAMED",
			"--add-opens", "java.base/java.lang=ALL-UNNAMED",
			"-jar", equinox_path,
			"-configuration", config_path,
			"-data", data_path,
		},
		root_dir = vim.fs.root(0, { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }),
		settings = { java = {} },
		init_options = { bundles = bundles },
	}
end

local function on_attach(_, bufnr)
	local opts = { buffer = bufnr }
	vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "LSP: Rename symbol" }))
	vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "LSP: Hover documentation" }))
end

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

		vim.lsp.config("angularls", vim.tbl_deep_extend("force", { on_attach = on_attach }, {
			root_dir = function(fname)
				local lspconfig = require("lspconfig")
				local root = lspconfig.util.root_pattern("angular.json", "workspace.json", "project.json")(fname)
				return root or nil
			end,
		}))
		vim.lsp.config("emmet_language_server", vim.tbl_deep_extend("force", { on_attach = on_attach }, {}))
		vim.lsp.config("html", vim.tbl_deep_extend("force", { on_attach = on_attach }, {
			filetypes = { "html" },
		}))
		vim.lsp.config("jdtls", vim.tbl_deep_extend("force", { on_attach = on_attach }, get_jdtls_config()))
		vim.lsp.config("lua_ls", vim.tbl_deep_extend("force", { on_attach = on_attach }, {
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						checkThirdParty = false,
						library = vim.api.nvim_get_runtime_file("", true),
					},
				},
			},
		}))
		vim.lsp.config("pyright", vim.tbl_deep_extend("force", { on_attach = on_attach }, {}))
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
			},
		}))

		require("mason-lspconfig").setup({})
	end,
}
