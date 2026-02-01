return {
	"github/copilot.vim",
	-- cmd = { "Copilot" },
	-- ft = { "python", "lua", "typescript", "markdown", "terraform" },
	cond = function()
		return vim.fn.executable("gh") == 1
	end,
	init = function()
		vim.keymap.set("i", "<M-w>", "<Plug>(copilot-accept-word)")
		vim.keymap.set("i", "<M-e>", "<Plug>(copilot-accept-line)")
	end,
}
