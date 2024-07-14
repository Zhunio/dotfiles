-- file
vim.keymap.set("n", "<leader>w", ":w<CR>")
vim.keymap.set("n", "<leader>o", function()
	vim.lsp.buf.execute_command({
		command = "_typescript.organizeImports",
		arguments = { vim.api.nvim_buf_get_name(0) },
		title = "Organize Imports",
	})
end)
vim.keymap.set({ "n", "v" }, "<leader>f", function()
	require("conform").format({
		lsp_fallback = true,
		async = false,
		timeout_ms = 500,
	})
end)

-- indentation
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- move lines
vim.keymap.set("v", "J", ":move .+1<CR>==")
vim.keymap.set("v", "K", ":move .-1<CR>==")
vim.keymap.set("x", "J", ":move '>+1<CR>gv-gv")
vim.keymap.set("x", "K", ":move '<-2<CR>gv-gv")

-- window split
vim.keymap.set("n", "<leader>ss", ":split<CR>")
vim.keymap.set("n", "<leader>sv", ":vsplit<CR>")

-- buffers
vim.keymap.set("n", "<leader>h", ":bprevious<CR>")
vim.keymap.set("n", "<leader>l", ":bnext<CR>")
vim.keymap.set("n", "<leader><left>", ":BufferLineMovePrev<CR>")
vim.keymap.set("n", "<leader><right>", ":BufferLineMoveNext<CR>")
vim.keymap.set("n", "<leader>q", function()
	require("close_buffers").delete({ type = "this" })
end)

-- git actions
vim.keymap.set("n", "gS", ":Gitsigns stage_hunk<CR>")
vim.keymap.set("n", "gU", ":Gitsigns undo_stage_hunk<CR>")
vim.keymap.set("n", "gC", ":Gitsigns reset_hunk<CR>")
vim.keymap.set("n", "gs", ":Gitsigns stage_buffer<CR>")
vim.keymap.set("n", "gu", ":Gitsigns reset_buffer_index<CR>")
vim.keymap.set("n", "gc", ":Gitsigns reset_buffer<CR>")
vim.keymap.set("n", "gj", ":Gitsigns next_hunk<CR>")
vim.keymap.set("n", "gk", ":Gitsigns prev_hunk<CR>")
vim.keymap.set("n", "gK", ":Gitsigns preview_hunk<CR>")
vim.keymap.set("n", "gt", ":Gitsigns toggle_current_line_blame<CR>")

--  resize windows
vim.keymap.set("n", "<C-right>", ":vertical resize +2<CR>")
vim.keymap.set("n", "<C-down>", ":resize +2<CR>")
vim.keymap.set("n", "<C-left>", ":vertical resize -2<CR>")
vim.keymap.set("n", "<C-up>", ":resize -2<CR>")

-- Override pasting
vim.keymap.set("v", "p", '"_dP')

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- testing
vim.keymap.set("n", "<leader>te", ":Neotest summary<CR>")
vim.keymap.set("n", "<leader>to", ":Neotest output<CR>")
vim.keymap.set("n", "<leader>tp", ":Neotest output-panel toggle<CR>")
vim.keymap.set("n", "<leader>tt", ":lua require('neotest').run.run(vim.fn.expand('%'))<CR>")
vim.keymap.set("n", "<leader>tc", ":lua require('neotest').run.run()<CR>")
