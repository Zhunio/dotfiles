return {
	{ "sindrets/diffview.nvim", lazy = true },
	{
		"NeogitOrg/neogit",
		cmd = { "Neogit" },
    --stylua: ignore
		keys = {
			{ "gn", function() require("neogit").open({ kind = "auto" }) end },
		},
		config = function()
			local neogit = require("neogit")

			neogit.setup({
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
						hidden = false,
					},
				},
			})
		end,
	},
}
