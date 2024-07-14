vim.g.mapleader = " "
vim.opt.clipboard = "unnamedplus"
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.termguicolors = true

if vim.g.vscode then
  -- no special options for now
else
  vim.opt.relativenumber = true
  vim.opt.expandtab = true
  vim.opt.tabstop = 2
  vim.opt.shiftwidth = 2
end
