return {
	{
		"mistweaverco/kulala.nvim",
		ft = { "http" },
		opts = {},
		init = function()
			vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
				pattern = "*.http",
          -- stylua: ignore
				callback = function()
					vim.bo.filetype = "http"
          vim.cmd("TSEnable highlight")

					vim.keymap.set("n", "<CR>", function() require("kulala").run() end, { buffer = 0 })
					vim.keymap.set("n", "<leader>kc", function() require("kulala").copy() end, { buffer = 0 })
					vim.keymap.set("n", "<leader>kf", function() require("kulala").from_curl() end, { buffer = 0 })
					vim.keymap.set("n", "<leader>kq", function() require("kulala").close() end, { buffer = 0 })
					vim.keymap.set("n", "<leader>kt", function() require("kulala").toggle_view() end, { buffer = 0 })
					vim.keymap.set("n", "<leader>ki", function() require("kulala").inspect() end, { buffer = 0 })
					vim.keymap.set("n", "gj", function() require("kulala").jump_next() end, { buffer = 0 })
					vim.keymap.set("n", "gk", function() require("kulala").jump_prev() end, { buffer = 0 })
				end,
			})
		end,
	},
}
