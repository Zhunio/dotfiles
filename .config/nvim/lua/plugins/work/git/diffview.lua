return {
	{
		"sindrets/diffview.nvim",
		cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    --stylua: ignore
		opts = {
			enhanced_diff_hl = true,
		},
		init = function()
			-- Fix dash lines in diff view (https://github.com/sindrets/diffview.nvim/issues/35)
			-- vim.opt.fillchars = vim.opt.fillchars + "diff:╱"
			vim.opt.fillchars = vim.opt.fillchars + "diff: "

			local function set_diffview_keymaps()
				local keymapOptions = { noremap = true, silent = true, buffer = true }

				vim.keymap.set("n", "q", ":tabclose<CR>", keymapOptions)
			end

			vim.api.nvim_create_autocmd("FileType", {
				pattern = "Diffview*",
				callback = set_diffview_keymaps,
			})
		end,
	},
}
