local with_plugin = require("config.with-plugin")

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

return {
	require("plugins.shared.nvim-cmp"),
	require("plugins.shared.treesitter"),
	with_plugin("plugins.shared.conform", {
		opts = {
			formatters_by_ft = {
				java = { "google-java-format" },
				xml = { "xmlformatter" },
			},
		},
	}),
	with_plugin("plugins.shared.mason-tool-installer", {
		opts = {
			ensure_installed = { "java-test", "java-debug-adapter", "jdtls", "google-java-format", "xmlformatter" },
		},
	}),
	with_plugin("plugins.shared.mason-lspconfig", {
		config = function()
			local on_attach = require("plugins.shared.on-attach")
			vim.lsp.config("jdtls", vim.tbl_deep_extend("force", { on_attach = on_attach }, get_jdtls_config()))

			local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
			end

			vim.diagnostic.config({ virtual_text = true })
			require("mason-lspconfig").setup({})
		end,
	}),
	{ "mfussenegger/nvim-jdtls", ft = { "java" } },
}
