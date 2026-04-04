local M = {}

function M.setup(on_attach)
  vim.lsp.config("pyright", vim.tbl_deep_extend("force", { on_attach = on_attach }, {}))
end

return M
