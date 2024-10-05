return {
	{ "christoomey/vim-tmux-navigator" },
	-- {
	-- 	"goolord/alpha-nvim",
	-- 	dependencies = { "nvim-tree/nvim-web-devicons" },
	-- 	config = function()
	-- 		local alpha = require("alpha")
	-- 		local dashboard = require("alpha.themes.startify")
	--
	-- 		dashboard.section.header.val = {
	-- 			[[                                                                       ]],
	-- 			[[                                                                       ]],
	-- 			[[                                                                       ]],
	-- 			[[                                                                       ]],
	-- 			[[                                                                     ]],
	-- 			[[       ████ ██████           █████      ██                     ]],
	-- 			[[      ███████████             █████                             ]],
	-- 			[[      █████████ ███████████████████ ███   ███████████   ]],
	-- 			[[     █████████  ███    █████████████ █████ ██████████████   ]],
	-- 			[[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
	-- 			[[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
	-- 			[[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
	-- 			[[                                                                       ]],
	-- 			[[                                                                       ]],
	-- 			[[                                                                       ]],
	-- 		}
	--
	-- 		alpha.setup(dashboard.opts)
	-- 	end,
	-- },
	{
		"nvim-lualine/lualine.nvim",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			{ "nvim-tree/nvim-web-devicons" },
			{ "yavorski/lualine-macro-recording.nvim" },
		},
		config = function()
			require("lualine").setup({
				options = {
					theme = "catppuccin",
				},
				sections = {
					lualine_c = { "macro_recording", "%S" },
				},
			})

			vim.cmd("set cmdheight=1")
		end,
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		cmd = { "Neotree" },
		keys = {
			{ "<leader>ef", ":Neotree reveal=true position=float toggle=true<CR>" },
			{ "<leader>ee", ":Neotree reveal=true position=left toggle=true<CR>" },
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("nvim-treesitter.configs").setup({
				auto_install = true,
				hightlight = { enable = true },
				indent = { enable = true },
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<C-Space>",
						node_incremental = "<C-Space>",
						scope_incremental = false,
						node_decremental = "<bs>",
					},
				},
			})
		end,
	},
	{
		"echasnovski/mini.tabline",
		event = { "BufReadPre", "BufNewFile" },
		version = "*",
		config = function()
			require("mini.tabline").setup()
		end,
	},
	{
		"echasnovski/mini.pairs",
		event = "InsertEnter",
		version = "*",
		config = function()
			require("mini.pairs").setup()
		end,
	},
	{
		"kazhala/close-buffers.nvim",
  -- stylua: ignore
		keys = {
			{ "<leader>q", function() require("close_buffers").delete({ type = "this" }) end },
		},
	},
	{
		"stevearc/conform.nvim",
  -- stylua: ignore
	keys = {
		{ "<leader>f", function() require("conform").format({ lsp_fallback = true, async = false, timeout_ms = 500 }) end },
	},
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
					javascript = { "prettier" },
					typescript = { "prettier" },
					css = { "prettier" },
					html = { "prettier" },
					json = { "prettier" },
					yaml = { "prettier" },
					markdown = { "prettier" },
				},
			})
		end,
	},
	{
		"echasnovski/mini.notify",
		event = "VeryLazy",
		config = function()
			require("mini.notify").setup({
				background_colour = "#000000",
			})
		end,
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = { "MunifTanjim/nui.nvim" },
		config = function()
			require("noice").setup({
				presets = {
					bottom_search = true, -- use a classic bottom cmdline for search
					long_message_to_split = true, -- long messages will be sent to a split
					inc_rename = false, -- enables an input dialog for inc-rename.nvim
					lsp_doc_border = false, -- add a border to hover docs and signature help
				},
			})
		end,
	},
	{
		"folke/flash.nvim",
		event = { "BufReadPre", "BufNewFile" },
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
	},
	{
		"numToStr/Comment.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("Comment").setup({
				toggler = { line = "<leader>c" },
				opleader = { line = "<leader>c" },
			})
		end,
	},
}
