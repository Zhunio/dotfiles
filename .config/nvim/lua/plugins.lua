return {
	-- Startup
	{
		"goolord/alpha-nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},

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
	-- Theme
	-- {
	--   "olimorris/onedarkpro.nvim",
	--   priority = 1000,
	--   config = function()
	--     require("onedarkpro").setup({
	--       styles = {
	--         comments = "italic",
	--         keywords = "bold"
	--       },
	--       options = {
	--         transparency = true,
	--       },
	--       highlights = {
	--         -- purple
	--         ["Function"] = { link = "Keyword" },
	--         ["typescriptImport"] = { link = "Keyword" },
	--         ["typescriptExport"] = { link = "Keyword" },
	--         ["typescriptIdentifier"] = { link = "Keyword" },
	--         ["typescriptVariable"] = { link = "Keyword" },
	--         ["typescriptCastKeyword"] = { link = "Keyword" },
	--         -- red
	--         ["Identifier"] = { fg = "${red}", bold = true },
	--         ["typescriptBlock"] = { link = "Identifier" },
	--         ["typescriptMember"] = { link = "Identifier" },
	--         ["@lsp.type.property.typescript"] = { link = "Identifier" },
	--         ["@lsp.mod.readonly.typescript"] = { link = "Identifier" },
	--         -- green
	--         ["typescriptString"] = { fg = "${green}", bold = true },
	--         -- blue
	--         ["typescriptFuncName"] = { fg = "${blue}", bold = true },
	--         ["@lsp.type.function.typescript"] = { link = "typescriptFuncName" },
	--         ["@lsp.type.member.typescript"] = { link = "typescriptFuncName" },
	--         ["@lsp.type.method.lua"] = { link = "typescriptFuncName" },
	--         -- yellow
	--         ["typescriptCall"] = { fg = "${yellow}", bold = true },
	--         ["typescriptPredefinedType"] = { link = "typescriptCall" },
	--         ["@lsp.type.parameter.typescript"] = { link = "typescriptCall" },
	--         ["@lsp.type.interface.typescript"] = { link = "typescriptCall" },
	--         ["@lsp.type.class.typescript"] = { link = "typescriptCall" },
	--         -- other color
	--         ["@lsp.type.variable.typescript"] = { link = "@constant" },
	--         ["@variable"] = { link = "@constant" },
	--       },
	--     })
	--     vim.cmd("colorscheme onedark")
	--   end,
	-- },
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		opts = {},
		config = function()
			require("catppuccin").setup({
				transparent_background = true,
				integrations = {
					diffview = true,
				},
				highlight_overrides = {
					mocha = function(mocha)
						return {
							yamlBlockMappingKey = { fg = mocha.lavender },
							yamlPlainScalar = { fg = mocha.green },
							typescriptImport = { link = "Keyword" },
							typescriptVariable = { link = "Keyword" },
							typescriptExport = { link = "Keyword" },
						}
					end,
				},
			})
			vim.cmd("colorscheme catppuccin-mocha")
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
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
		end,
	},
	-- File Explorer
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("neo-tree").setup({})
			vim.keymap.set("n", "<leader>ee", ":Neotree reveal=true toggle=true<CR>")
			vim.keymap.set("n", "<leader>ef", ":Neotree reveal=true position=float toggle=true<CR>")
			vim.keymap.set("n", "<leader>ed", ":DBUIToggle<CR>")
		end,
	},
	-- Tabs
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("bufferline").setup({
				options = {
					truncate_names = false,
					mode = "buffers",
					offsets = {
						{
							filetype = "NvimTree",
							highlight = "Directory",
							separator = true,
						},
					},
				},
			})
		end,
	},
	{
		"kazhala/close-buffers.nvim",
	},
	-- Telescope
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
			vim.keymap.set("n", "<leader>fp", ":Telescope current_buffer_fuzzy_find<CR>", {})
			vim.keymap.set("n", "<leader>fc", ":Telescope commands<CR>", {})
			vim.keymap.set("n", "<leader>fb", builtin.git_branches, {})
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
			vim.keymap.set("n", "<leader>fo", builtin.oldfiles, {})
		end,
	},
	-- LSP & Treesitter
	{
		"williamboman/mason.nvim",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"neovim/nvim-lspconfig",
		},
		config = function()
			require("mason").setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})

			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "html", "cssls", "ts_ls", "angularls" },
				automatic_installation = true,
			})

			local on_attach = function()
				vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, {})
				vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
				vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, {})
				vim.keymap.set("n", "g=", vim.lsp.buf.code_action, {})
			end

			local lspConfig = require("lspconfig")
			lspConfig.lua_ls.setup({ on_attach = on_attach })
			lspConfig.html.setup({ on_attach = on_attach })
			lspConfig.cssls.setup({ on_attach = on_attach })
			lspConfig.ts_ls.setup({ on_attach = on_attach })
			lspConfig.angularls.setup({ on_attach = on_attach })

			-- Change the Diagnostic symbols in the sign column (gutter)
			local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
			end
		end,
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
	-- auto completion
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lsp",
			"saadparwaiz1/cmp_luasnip",
			"onsails/lspkind.nvim",
			"L3MON4D3/LuaSnip",
			"rafamadriz/friendly-snippets",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local lspkind = require("lspkind")

			require("luasnip.loaders.from_vscode").lazy_load()

			cmp.setup({
				completion = {
					completeopt = "menu,menuone,noselect",
				},
				window = {
					documentation = {
						border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
					},
					completion = {
						border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
					},
				},
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-k>"] = cmp.mapping.select_prev_item(),
					["<C-j>"] = cmp.mapping.select_next_item(),
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm(),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "path" },
					{ name = "buffer" },
					{ name = "luasnip" },
				}),
				-- formatting = {
				-- 	fields = { "kind", "abbr", "menu" },
				-- 	format = function(entry, vim_item)
				-- 		vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
				-- 		vim_item.menu = ({})[entry.source.name]
				--
				-- 		return vim_item
				-- 	end,
				-- },
				formatting = {
					fields = { "kind", "abbr", "menu" },
					format = lspkind.cmp_format({
						mode = "symbol",
						maxwidth = 300,
						ellipsis_char = "...",
					}),
				},
			})

			-- setup vim-dadbod-completion
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "sql", "mysql", "pslsql" },
				callback = function()
					cmp.setup.buffer({
						sources = {
							{ name = "vim-dadbod-completion" },
						},
					})
				end,
			})

			-- Transparent window
			vim.cmd("highlight Pmenu guibg=NONE")
		end,
	},
	-- git
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "┃" },
					change = { text = "┃" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
					untracked = { text = "┆" },
				},
				signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
				numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
				linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
				word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
				watch_gitdir = { follow_files = true },
				auto_attach = true,
				attach_to_untracked = false,
				current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
				current_line_blame_opts = {
					virt_text = true,
					virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
					delay = 1000,
					ignore_whitespace = false,
					virt_text_priority = 100,
				},
				current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
				-- current_line_blame_formatter_opts = {
				-- 	relative_time = false,
				-- },
				sign_priority = 6,
				update_debounce = 100,
				status_formatter = nil, -- Use default
				max_file_length = 40000, -- Disable if file is longer than this (in lines)
				preview_config = {
					-- Options passed to nvim_open_win
					border = "single",
					style = "minimal",
					relative = "cursor",
					row = 0,
					col = 1,
				},
			})
		end,
	},
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"sindrets/diffview.nvim", -- optional - Diff integration

			-- Only one of these is needed, not both.
			"nvim-telescope/telescope.nvim", -- optional
			-- "ibhagwan/fzf-lua", -- optional
		},
		config = function()
			require("neogit").setup({
				graph_style = "unicode",
			})
		end,
	},
	-- formatting
	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
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
				format_on_save = {
					lsp_fallback = true,
					async = false,
					timeout_ms = 500,
				},
			})
		end,
	},
	-- other
	{
		"mg979/vim-visual-multi",
	},
	{
		"christoomey/vim-tmux-navigator",
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},
	{ "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup({
				toggler = { line = "<leader>c" },
				opleader = { line = "<leader>c" },
			})
		end,
	},
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {
			modes = {
				search = { enabled = true, highlight = { backdrop = true } },
			},
		},
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash Treesitter",
			},
		},
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {},
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		config = function()
			require("notify").setup({
				background_colour = "#000000",
			})
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
	-- markdown support
	{
		"MeanderingProgrammer/render-markdown.nvim",
		opts = {},
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
	},
	-- db
	{
		"kristijanhusak/vim-dadbod-ui",
		dependencies = {
			{ "tpope/vim-dadbod", lazy = true },
			{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
		},
		cmd = {
			"DBUI",
			"DBUIToggle",
			"DBUIAddConnection",
			"DBUIFindBuffer",
		},
		init = function()
			vim.g.db_ui_use_nerd_fonts = 1
		end,
	},
	-- testing
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
			"nvim-neotest/neotest-jest",
		},
		config = function()
			require("neotest").setup({
				adapters = {
					require("neotest-jest")({
						jestCommand = "npm test --",
						jestConfigFile = "custom.jest.config.ts",
						env = { CI = true },
						cwd = function(path)
							return vim.fn.getcwd()
						end,
					}),
				},
			})
		end,
	},
}
