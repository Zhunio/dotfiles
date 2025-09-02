return {
	"kndndrj/nvim-dbee",
	cmd = {
		"Dbee",
	},
	build = function()
		require("dbee").install()
	end,
	config = function()
		require("dbee").setup({
			sources = {
				require("dbee.sources").EnvSource:new("DBEE_CONNECTIONS"),
			},
		})
	end,
}
