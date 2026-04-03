return function(plugin, overrides)
	return vim.tbl_deep_extend("force", require(plugin), overrides)
end
