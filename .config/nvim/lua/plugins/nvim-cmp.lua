return {
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
}
