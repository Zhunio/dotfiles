return {
	{
		"mfussenegger/nvim-jdtls",
		ft = "java",
		config = function()
			require("jdtls").start_or_attach({
				cmd = { vim.fn.stdpath("data") .. "/mason/bin/jdtls" },
				root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1]),
			})
		end,
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		ft = { "markdown" },
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
}
