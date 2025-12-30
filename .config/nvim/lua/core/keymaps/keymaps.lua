-- Escape insert mode with 'jj' or 'jk'
vim.keymap.set("i", "jj", "<Esc>")
vim.keymap.set("i", "jk", "<Esc>")

-- file
vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save file" })

-- indentation
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- move lines
vim.keymap.set("v", "J", ":move .+1<CR>==")
vim.keymap.set("v", "K", ":move .-1<CR>==")
vim.keymap.set("x", "J", ":move '>+1<CR>gv-gv")
vim.keymap.set("x", "K", ":move '<-2<CR>gv-gv")

-- window split
vim.keymap.set("n", "<leader>ss", ":split<CR>", { desc = "Horizontal Split" })
vim.keymap.set("n", "<leader>sv", ":vsplit<CR>", { desc = "Vertical Split" })

--  resize windows
vim.keymap.set("n", "<C-right>", ":vertical resize +2<CR>", { desc = "Vertical Resize +" })
vim.keymap.set("n", "<C-down>", ":resize +2<CR>", { desc = "Horizontal Resize +" })
vim.keymap.set("n", "<C-left>", ":vertical resize -2<CR>", { desc = "Vertical Resize -" })
vim.keymap.set("n", "<C-up>", ":resize -2<CR>", { desc = "Horizontal Resize -" })

-- Override pasting
vim.keymap.set("v", "p", '"_dP')

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
