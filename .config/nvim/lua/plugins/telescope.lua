return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.5",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
		vim.keymap.set("n", "<leader>fp", builtin.commands, {})
		vim.keymap.set("n", "<leader>ft", builtin.buffers, {})
		vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
		vim.keymap.set("n", "<leader>f?", builtin.current_buffer_fuzzy_find, {})
		vim.keymap.set("n", "<leader>fb", builtin.git_branches, {})
		vim.keymap.set("n", "<leader>fr", builtin.registers, {})
		vim.keymap.set("n", "<leader>fq", builtin.quickfix, {})
	end,
}
