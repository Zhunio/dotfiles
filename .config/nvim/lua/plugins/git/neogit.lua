return {
	{
		"NeogitOrg/neogit",
		cmd = { "Neogit" },
    --stylua: ignore
		keys = {
			{ "gn", function() require("neogit").open() end },
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",
			"ibhagwan/fzf-lua",
		},
		config = function()
			local neogit = require("neogit")

			neogit.setup({
				kind = "auto",
				graph_style = "unicode",
				signs = {
					hunk = { "", "" },
					item = { "", "" },
					section = { "", "" },
				},
				disable_insert_on_commit = true,
				commit_editor = {
					staged_diff_split_kind = "auto",
					spell_check = false,
				},
				sections = {
					recent = {
						folded = false,
					},
				},
			})
		end,
	},
}
