local on_attach = require("config.lsp.on_attach")

local angularls_path = vim.fn.stdpath("data") .. "/mason/packages/angular-language-server"
local cmd = {
	"ngserver",
	"--stdio",
	"--tsProbeLocations",
	angularls_path,
	"--ngProbeLocations",
	angularls_path .. "/node_modules/@angular/language-server",
}

return {
	cmd = cmd,
	on_attach = on_attach,
	on_new_config = function(new_config, new_root_dir)
		new_config.cmd = cmd
	end,
}
