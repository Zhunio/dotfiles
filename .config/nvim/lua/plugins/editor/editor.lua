return {
	{
		"olimorris/persisted.nvim",
		lazy = false,
		config = function()
			local persisted = require("persisted")

			local function should_save()
				local isAlpha = vim.bo.filetype == "alpha"
				if isAlpha then
					return false
				else
				end

				local isEmptyBuffer = vim.api.nvim_buf_get_name(0) == ""
				if isEmptyBuffer then
					persisted.delete()
					return false
				end

				return true
			end

			persisted.setup({
				autoload = true,
				should_save = should_save,
			})
		end,
	},
	{ "christoomey/vim-tmux-navigator" },
	{
		"romgrk/barbar.nvim",
		event = { "BufReadPre", "BufNewFile" },
		keys = {
			{ "<leader>q", ":BufferClose<CR>" },
			{ "<leader>h", ":BufferPrevious<CR>" },
			{ "<leader>l", ":BufferNext<CR>" },
			{ "<leader><left>", ":BufferMovePrevious<CR>" },
			{ "<leader><right>", ":BufferMoveNext<CR>" },
		},
		opts = {},
	},
	{
		"nvim-lualine/lualine.nvim",
		opts = {
			options = {
				theme = "catppuccin",
			},
		},
	},
	{
		"numToStr/Comment.nvim",
		keys = {
			{ "<leader>c", mode = { "n", "x", "o" } },
		},
		opts = {
			toggler = { line = "<leader>c" },
			opleader = { line = "<leader>c" },
		},
		init = function()
			local ft = require("Comment.ft")
			-- set only line comment
			ft.set("http", "#%s")
		end,
	},
	{
		"kylechui/nvim-surround",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},
	{
		"arnamak/stay-centered.nvim",
		opts = {
			skip_filetypes = { "alpha" },
		},
	},
	{
		"szw/vim-maximizer",
		keys = {
			{ "<C-f>", ":MaximizerToggle<CR>" },
		},
	},
}
