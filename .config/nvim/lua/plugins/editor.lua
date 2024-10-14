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
		"romgrk/barbar.nvim",
		event = { "BufReadPre", "BufNewFile" },
    -- stylua: ignore
    keys = {
			{ "<leader>q", ":BufferClose<CR>" },
			{ "<leader>h", ":BufferPrevious<CR>" },
			{ "<leader>l", ":BufferNext<CR>" },
			{ "<leader><left>", ":BufferMovePrevious<CR>" },
			{ "<leader><right>", ":BufferMoveNext<CR>" },
			{ "<leader>bp", ":BufferPick<CR>" },
			{ "<leader>bx", ":BufferPickDelete<CR>" },
    },
		dependencies = {
			"lewis6991/gitsigns.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		init = function()
			vim.g.barbar_auto_setup = false
		end,
		opts = {},
	},
	{
		"stevearc/conform.nvim",
  -- stylua: ignore
    keys = {
      { "gf", function() require("conform").format() end },
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
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},
	{
		"petertriho/nvim-scrollbar",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local C = require("catppuccin.palettes").get_palette("mocha")

			require("scrollbar").setup({
				handle = {
					color = C.overlay2,
				},
				marks = {
					Search = { color = C.maroon },
					Error = { color = C.red },
					Warn = { color = C.yellow },
					Info = { color = C.blue },
					Hint = { color = C.lavender },
					Misc = { color = C.mauve },
				},
			})
		end,
	},
	{
		"kylechui/nvim-surround",
		event = "InsertEnter",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},
	{
		"norcalli/nvim-colorizer.lua",
		event = "BufReadPre", "BufNewFile",
		config = function()
			require("colorizer").setup()
		end,
	},
	{
		"karb94/neoscroll.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("neoscroll").setup({})
		end,
	},
}
