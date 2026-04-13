return {
	{
		"folke/persistence.nvim",
		event = "BufReadPre",
		keys = {
      { "<leader>qs", mode = { "n" }, function() require("persistence").load() end },
      { "<leader>qS", mode = { "n" }, function() require("persistence").select() end },
      { "<leader>ql", mode = { "n" }, function() require("persistence").load({ last = true }) end },
      { "<leader>qd", mode = { "n" }, function() require("persistence").stop() end }
		},
		opts = {
			need = 0, -- Set to 0 to always save
      branch = true -- use git branch to save session
		},
	},
}
