return {
	{
		"oysandvik94/curl.nvim",
		cmd = { "CurlOpen" },
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = true,
		init = function()
			vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
				pattern = "*.curl",
				callback = function()
					vim.bo.filetype = "bash"
          -- stylua: ignore
					vim.keymap.set("n", "<CR>", function() require("curl").execute_curl() end, { buffer = 0 })
				end,
			})
		end,
	},
}
