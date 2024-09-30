return {
	{
		"mistweaverco/kulala.nvim",
    -- stylua: ignore
    keys = {
      { "<leader>kk", function () require('kulala').run() end },
      { "<leader>kc", function () require('kulala').from_curl() end },
    },
		opts = {},
	},
}
