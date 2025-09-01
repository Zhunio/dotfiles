-- stylua: ignore start

-- file
vim.keymap.set("n", "<leader>w", function() require("vscode-neovim").call("workbench.action.files.save") end)
vim.keymap.set("n", "<leader>q", function() require("vscode-neovim").action("workbench.action.closeActiveEditor") end)
vim.keymap.set("n", "gf", function() require("vscode-neovim").call("editor.action.formatDocument") end)
vim.keymap.set("n", "gO", function() require("vscode-neovim").call("editor.action.organizeImports") end)
-- indentation
vim.keymap.set({ "n", "x" }, ">", function() require("vscode-neovim").action("editor.action.indentLines") end)
vim.keymap.set({ "n", "x" }, "<", function() require("vscode-neovim").action("editor.action.outdentLines") end)
-- window split
vim.keymap.set("n", "<leader>ss", function() require("vscode-neovim").action("workbench.action.splitEditorDown") end)
vim.keymap.set("n", "<leader>sv", function() require("vscode-neovim").action("workbench.action.splitEditor") end)
-- buffers
vim.keymap.set("n", "<leader>l", function() require("vscode-neovim").action("workbench.action.nextEditor") end)
vim.keymap.set("n", "<leader>h", function() require("vscode-neovim").action("workbench.action.previousEditor") end)
vim.keymap.set("n", "<leader><left>", function() require("vscode-neovim").action("workbench.action.moveEditorLeftInGroup") end)
vim.keymap.set("n", "<leader><right>", function() require("vscode-neovim").action("workbench.action.moveEditorRightInGroup") end)
-- window management
vim.keymap.set("n", "<C-l>", function() require("vscode-neovim").action("workbench.action.navigateRight") end)
vim.keymap.set("n", "<C-j>", function() require("vscode-neovim").action("workbench.action.navigateDown") end)
vim.keymap.set("n", "<C-h>", function() require("vscode-neovim").action("workbench.action.navigateLeft") end)
vim.keymap.set("n", "<C-k>", function() require("vscode-neovim").action("workbench.action.navigateUp") end)
-- resize windows
vim.keymap.set("n", "<C-right>", function() require("vscode-neovim").action("workbench.action.increaseViewWidth") end)
vim.keymap.set("n", "<C-down>", function() require("vscode-neovim").action("workbench.action.increaseViewHeight") end)
vim.keymap.set("n", "<C-left>", function() require("vscode-neovim").action("workbench.action.decreaseViewWidth") end)
vim.keymap.set("n", "<C-up>", function() require("vscode-neovim").action("workbench.action.decreaseViewHeight") end)
-- code actions
vim.keymap.set("n", "<leader>r", function() require("vscode-neovim").action("editor.action.rename") end)
vim.keymap.set("n", "gk", function() require("vscode-neovim").action("editor.action.showHover") end)
vim.keymap.set("n", "gh", function() require("vscode-neovim").action("editor.action.triggerParameterHints") end)
vim.keymap.set("n", "gd", function() require("vscode-neovim").action("editor.action.revealDefinition") end)
vim.keymap.set("n", "gD", function() require("vscode-neovim").action("editor.action.peekDefinition") end)
vim.keymap.set("n", "gr", function() require("vscode-neovim").action("editor.action.goToReferences") end)
vim.keymap.set("n", "g=", function() require("vscode-neovim").action("editor.action.quickFix") end)
-- git actions
vim.keymap.set("v", "gS", function() require("vscode-neovim").action("git.stageSelectedRanges") end)
vim.keymap.set("v", "gU", function() require("vscode-neovim").action("git.unstageSelectedRanges") end)
vim.keymap.set("v", "gC", function() require("vscode-neovim").action("git.revertSelectedRanges") end)
vim.keymap.set("n", "gs", function() require("vscode-neovim").action("git.stage") end)
vim.keymap.set("n", "gu", function() require("vscode-neovim").action("git.unstage") end)
vim.keymap.set("n", "gc", function() require("vscode-neovim").action("git.clean") end)
vim.keymap.set("n", "go", function() require("vscode-neovim").action("gitlens.openWorkingFile") end)
vim.keymap.set("n", "gi", function() require("vscode-neovim").action("toggle.diff.renderSideBySide") end)
vim.keymap.set("n", "gj", function()
	require("vscode-neovim").action("workbench.action.editor.nextChange")
	require("vscode-neovim").action("workbench.action.compareEditor.nextChange")
end)
vim.keymap.set("n", "gk", function()
	require("vscode-neovim").action("workbench.action.editor.previousChange")
	require("vscode-neovim").action("workbench.action.compareEditor.previousChange")
end)
vim.keymap.set("n", "gR", function()
	require("vscode-neovim").call("workbench.action.output.toggleOutput")
	require("vscode-neovim").call("workbench.output.action.clearOutput")
	vim.api.nvim_command(":registers")
end)
-- git pull requests
vim.keymap.set("n", "gpp", function() require("vscode-neovim").action("prStatus:github.focus") end)
vim.keymap.set("n", "gpl", function() require("vscode-neovim").action("pr:github.focus") end)
vim.keymap.set("n", "gpb", function() require("vscode-neovim").action("pr.openPullRequestOnGitHub") end)
vim.keymap.set("n", "gpr", function() require("vscode-neovim").action("pr.focusDescriptionInput") end)
-- fold actions
vim.keymap.set("n", "zp", function() require("vscode-neovim").action("editor.gotoParentFold") end)
vim.keymap.set("n", "zC", function() require("vscode-neovim").action("editor.foldAll") end)
vim.keymap.set("n", "zO", function() require("vscode-neovim").action("editor.unfoldAll") end)
vim.keymap.set("n", "zj", function() require("vscode-neovim").action("editor.gotoNextFold") end)
vim.keymap.set("n", "zk", function() require("vscode-neovim").action("editor.gotoPreviousFold") end)
vim.keymap.set("n", "za", function() require("vscode-neovim").action("editor.toggleFold") end)
vim.keymap.set("n", "zs", function() require("vscode-neovim").action("editor.action.toggleStickyScroll") end)
--- Comments
vim.keymap.set({ "n", "x" }, "<leader>c", function() require("vscode-neovim").action("editor.action.commentLine") end)
-- Comment UI
-- vim.keymap.set("n", "<leader>ct", function() require("vscode-neovim").action("workbench.action.focusCommentsPanel") end)
-- vim.keymap.set("n", "<leader>cl", function() require("vscode-neovim").action("workbench.action.expandAllComments") end)
-- vim.keymap.set("n", "<leader>ch", function() require("vscode-neovim").action("workbench.action.collapseAllComments") end)
-- vim.keymap.set("n", "<leader>cj", function() require("vscode-neovim").action("editor.action.nextCommentedRangeAction") end)
-- vim.keymap.set("n", "<leader>ck", function() require("vscode-neovim").action("editor.action.previousCommentedRangeAction") end)
-- Override pasting
vim.keymap.set({ "n", "x" }, "<leader>p", '"_dP')
-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
-- Zoom
vim.keymap.set("n", "zr", function() require("vscode-neovim").action("workbench.action.zoomReset") end)
vim.keymap.set("n", "zi", function() require("vscode-neovim").action("workbench.action.zoomIn") end)
vim.keymap.set("n", "zo", function() require("vscode-neovim").action("workbench.action.zoomOut") end)
-- Testing
vim.keymap.set("n", "<leader>te", function() require("vscode-neovim").action("workbench.view.testing.focus") end)
vim.keymap.set("n", "<leader>to", function() require("vscode-neovim").action("testing.showMostRecentOutput") end)
vim.keymap.set("n", "<leader>ta", function() require("vscode-neovim").action("testing.runAll") end)
vim.keymap.set("n", "<leader>tf", function() require("vscode-neovim").action("testing.runCurrentFile") end)
vim.keymap.set("n", "<leader>tt", function() require("vscode-neovim").action("testing.runAtCursor") end)
vim.keymap.set("n", "<leader>ti", function() require("vscode-neovim").action("testing.toggleInlineTestOutput") end)

-- stylua: ignore end
