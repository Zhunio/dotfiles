return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		{ "L3MON4D3/LuaSnip" },
		{ "hrsh7th/cmp-nvim-lsp" },
		{ "hrsh7th/cmp-path" },
		{ "hrsh7th/cmp-buffer" },
		{ "saadparwaiz1/cmp_luasnip" },
		{ "rafamadriz/friendly-snippets" },
	},
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")

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
			formatting = {
				fields = { "kind", "abbr", "menu" },
				format = function(entry, vim_item)
					vim_item.kind = ({
						Text = "󰉿",
						Method = "󰆧",
						Function = "󰆧",
						Constructor = "󰆧",
						Field = "",
						Variable = "",
						Class = "",
						Interface = "",
						Module = "󰅩",
						Property = "",
						Unit = "󰑭",
						Value = "",
						Enum = "",
						Keyword = "󰌋",
						Snippet = "",
						Color = "",
						File = "󰈙",
						Reference = "",
						Folder = "",
						EnumMember = "",
						Constant = "",
						Struct = "",
						Event = "",
						Operator = "",
						TypeParameter = "",
					})[vim_item.kind]
					return vim_item
				end,
			},
		})

		-- Transparent window
		vim.cmd("highlight Pmenu guibg=NONE")
	end,
}