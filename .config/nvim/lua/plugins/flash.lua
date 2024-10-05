return {
	"folke/flash.nvim",
  -- stylua: ignore
  keys = {
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
  },
	opts = {
		modes = {
			search = { enabled = true, highlight = { backdrop = true } },
		},
	},
}
