return {
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
}
