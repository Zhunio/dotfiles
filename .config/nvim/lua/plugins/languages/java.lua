return {
	{
		"mfussenegger/nvim-jdtls",
		ft = "java",
		config = function()
			require("jdtls").start_or_attach({
				cmd = { vim.fn.stdpath("data") .. "mason/packages/jdtls/bin/jdtls" },
				root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1]),
			})
		end,
	},
}
