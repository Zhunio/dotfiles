return {
	{
		"echasnovski/mini.tabline",
		event = { "BufReadPre", "BufNewFile" },
		version = "*",
		config = function()
			require("mini.tabline").setup()
		end,
	},
	{
		"kazhala/close-buffers.nvim",
  -- stylua: ignore
		keys = {
			{ "<leader>q", function() require("close_buffers").delete({ type = "this" }) end },
		},
	},
}
