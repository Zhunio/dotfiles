return {
	{
		"mistweaverco/kulala.nvim",
		ft = { "http" },
		opts = {},
    -- stylua: ignore
    keys = {
      { "<leader>ks", function() require("kulala").scratchpad() end, desc = "Kulala: Open scratchpad" },
      { "<CR>", function() require("kulala").run() end, desc = "Kulala: Run current request" },
      { "<leader>kc", function() require("kulala").copy() end, desc = "Kulala: Copy current request as curl" },
      { "<leader>kf", function() require("kulala").from_curl() end, desc = "Kulala: Import from curl" },
      { "<leader>kq", function() require("kulala").close() end, desc = "Kulala: Close current request" },
      { "<leader>kt", function() require("kulala").toggle_view() end, desc = "Kulala: Toggle request/response view" },
      { "<leader>ki", function() require("kulala").inspect() end, desc = "Kulala: Inspect response" },
      { "gj", function() require("kulala").jump_next() end, desc = "Kulala: Jump to next request" },
      { "gk", function() require("kulala").jump_prev() end, desc= "Kulala: Jump to previous request" },
    },
		init = function()
			vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
				pattern = "*.http",
          -- stylua: ignore
				callback = function()
					vim.bo.filetype = "http"
          vim.cmd("TSEnable highlight")
				end,
			})
		end,
	},
}
