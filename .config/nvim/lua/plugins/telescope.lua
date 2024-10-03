return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.5",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local pickers = {}

		for _, picker in ipairs({ "git_branches", "find_files", "buffers" }) do
			pickers[picker] = {
				layout_config = {
					preview_height = 0.80,
				},
			}
		end

		require("telescope").setup({
			defaults = {
				prompt_prefix = " ",
				selection_caret = " ",
				multi_icon = " ",
				borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
				layout_strategy = "vertical",
				layout_config = {
					width = 0.99,
					height = 0.99,
					preview_height = 0.20,
					preview_cutoff = 0,
				},
			},
			pickers = pickers,
		})

		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
		vim.keymap.set("n", "<leader>fp", builtin.commands, {})
		vim.keymap.set("n", "<leader>fd", builtin.diagnostics, {})
		vim.keymap.set("n", "<leader>f@", builtin.lsp_document_symbols, {})
		vim.keymap.set("n", "<leader>ft", builtin.buffers, {})

		vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
		vim.keymap.set("n", "<leader>f?", builtin.current_buffer_fuzzy_find, {})

		vim.keymap.set("n", "<leader>fb", builtin.git_branches, {})

		vim.keymap.set("n", "<leader>fr", builtin.registers, {})
		vim.keymap.set("n", "<leader>fq", builtin.quickfix, {})
	end,
}
