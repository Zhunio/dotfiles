return {
	{ "christoomey/vim-tmux-navigator" },
	{
		"goolord/alpha-nvim",
		config = function()
			local alpha = require("alpha")
			local dashboard = require("alpha.themes.startify")

			dashboard.section.header.val = {
				[[                                                                       ]],
				[[                                                                       ]],
				[[                                                                       ]],
				[[                                                                       ]],
				[[                                                                     ]],
				[[       ████ ██████           █████      ██                     ]],
				[[      ███████████             █████                             ]],
				[[      █████████ ███████████████████ ███   ███████████   ]],
				[[     █████████  ███    █████████████ █████ ██████████████   ]],
				[[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
				[[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
				[[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
				[[                                                                       ]],
				[[                                                                       ]],
				[[                                                                       ]],
			}

			alpha.setup(dashboard.opts)
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "yavorski/lualine-macro-recording.nvim" },
		opts = {
			options = {
				theme = "catppuccin",
			},
			sections = {
				lualine_c = { "macro_recording", "%S" },
			},
		},
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		cmd = { "Neotree" },
		keys = {
			{ "<leader>ef", ":Neotree reveal=true position=float toggle=true<CR>" },
			{ "<leader>ee", ":Neotree reveal=true position=left toggle=true<CR>" },
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
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			presets = {
				bottom_search = true, -- use a classic bottom cmdline for search
				long_message_to_split = true, -- long messages will be sent to a split
				inc_rename = false, -- enables an input dialog for inc-rename.nvim
				lsp_doc_border = false, -- add a border to hover docs and signature help
			},
		},
	},
	{
		"folke/flash.nvim",
    -- stylua: ignore
    keys = {
      { "/" },
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
		keys = {
			{ "<leader>c", mode = { "n", "x", "o" } },
		},
		opts = {
			toggler = { line = "<leader>c" },
			opleader = { line = "<leader>c" },
		},
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
		"karb94/neoscroll.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("neoscroll").setup({})
		end,
	},
	{
		"mistweaverco/kulala.nvim",
    -- stylua: ignore
    keys = {
      { "<leader>kk", function () require('kulala').run() end },
    },
		opts = {},
	},
}
