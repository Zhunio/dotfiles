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

--  resize windows
vim.keymap.set("n", "<C-right>", ":vertical resize +2<CR>")
vim.keymap.set("n", "<C-down>", ":resize +2<CR>")
vim.keymap.set("n", "<C-left>", ":vertical resize -2<CR>")
vim.keymap.set("n", "<C-up>", ":resize -2<CR>")

-- toggle split full size
vim.keymap.set("n", "<C-f>", "<C-w>_<C-w>|")

-- toggle diagnostics
vim.keymap.set("n", "<leader>dd", function()
	vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end)

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
