return {
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		cmd = "Ibl",
		main = "ibl",
		init = function()
			vim.api.nvim_create_user_command("Ibl", function()
				require("lazy").load({ plugins = { "indent-blankline.nvim" } })
			end, { desc = "Load indent-blankline.nvim" })
		end,
		config = function(_, opts)
			require("ibl").setup({
				indent = { char = "▏" },
				scope = { char = "▎" },
			})
		end,
	},
}
