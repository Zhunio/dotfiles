return {
	"mistricky/codesnap.nvim",
	lazy = true,
	build = "make",
	cmd = { "CodeSnap", "CodeSnapSave", "CodeSnapHighlight", "CodeSnapSaveHighlight" },
	opts = {
		save_path = "~/CodeSnap",
		has_breadcrumbs = true,
		has_line_number = true,
		bg_theme = "default",
		bg_x_padding = 50,
		bg_y_padding = 50,
		bg_padding = nil,
	},
}
