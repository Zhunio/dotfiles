-- 💀Define the path to the lombok JAR (must be present for lombok support)
local lombok_path = vim.fn.glob("$MASON/packages/jdtls/lombok.jar")
-- 💀Define the path to the Equinox launcher JAR required to start the eclipse.jdt.ls (matches any version)
local equinox_path = vim.fn.glob("$MASON/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar")
-- 💀Define the path to the configuration for your system (linux, mac or win)
local config_path = vim.fn.glob("$MASON/packages/jdtls/config_mac")
-- 💀Define the path where eclipse.jdt.ls stores index data for each project it loads
local data_path = vim.fn.stdpath("cache") .. "/jdtls-data/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

-- 💀`cmd` Defines the executable to launch the eclipse.jdt.ls
local cmd = {
	-- 💀
	"java", -- or '/path/to/java21_or_newer/bin/java'
	"-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=1044",
	"-Declipse.application=org.eclipse.jdt.ls.core.id1",
	"-Dosgi.bundles.defaultStartLevel=4",
	"-Declipse.product=org.eclipse.jdt.ls.core.product",
	"-Dlog.protocol=true",
	"-Dlog.level=ALL",
	"-javaagent:" .. lombok_path,
	"-Xmx1g",
	"--add-modules=ALL-SYSTEM",
	"--add-opens",
	"java.base/java.util=ALL-UNNAMED",
	"--add-opens",
	"java.base/java.lang=ALL-UNNAMED",
	"-jar",
	equinox_path,
	"-configuration",
	config_path,
	"-data",
	data_path,
}

-- 💀Here you can configure eclipse.jdt.ls specific settings
-- https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
local settings = {
	java = {
		configuration = {
			runtimes = {
				{
					name = "JavaSE-17",
					path = vim.fn.glob(vim.fn.expand("~/.sdkman/candidates/java/17*")),
				},
				{
					name = "JavaSE-21",
					path = vim.fn.glob(vim.fn.expand("~/.sdkman/candidates/java/21*")),
				},
			},
		},
	},
}

-- 💀The `bundles` variable configures the paths to additional eclipse.jdt.ls plugins such as java-debug and java-test
local bundles = vim.tbl_flatten({
	vim.fn.glob("$MASON/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar", nil, true),
	vim.fn.glob("$MASON/packages/java-test/extension/server/*.jar", nil, true),
})
-- 💀bundles that we want to exclude
local excluded_bundles = {
	"com.microsoft.java.test.runner-jar-with-dependencies.jar",
	"jacocoagent.jar",
}
-- 💀Removes the `excluded_bundles` from the `bundles`
for i = #bundles, 1, -1 do
	local filename = vim.fn.fnamemodify(bundles[i], ":t")

	if vim.tbl_contains(excluded_bundles, filename) then
		table.remove(bundles, i)
	end
end

return {
	-- `cmd` defines the executable to launch eclipse.jdt.ls.
	cmd = cmd,

	-- `root_dir` must point to the root of your project.
	root_dir = vim.fs.root(0, { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }),

	-- `settings` Here you can configure eclipse.jdt.ls specific settings
	-- https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
	settings = settings,

	-- `init_options` This sets the `initializationOptions` sent to the language server
	-- https://codeberg.org/mfussenegger/nvim-jdtls#java-debug-installation
	init_options = {
		bundles = bundles,
	},
}
