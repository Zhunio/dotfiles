local M = {}

function M.setup(on_attach)
  vim.lsp.config("angularls", vim.tbl_deep_extend("force", { on_attach = on_attach }, {
    root_dir = function(fname)
      local lspconfig = require("lspconfig")
      local root = lspconfig.util.root_pattern("angular.json", "workspace.json", "project.json")(fname)
      return root or nil
    end,
  }))
  vim.lsp.config("emmet_language_server", vim.tbl_deep_extend("force", { on_attach = on_attach }, {}))
  vim.lsp.config("html", vim.tbl_deep_extend("force", { on_attach = on_attach }, {
    filetypes = { "html" },
  }))
end

return M
