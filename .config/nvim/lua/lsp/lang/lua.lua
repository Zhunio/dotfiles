local M = {}

function M.setup(on_attach)
  vim.lsp.config("lua_ls", vim.tbl_deep_extend("force", { on_attach = on_attach }, {
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          checkThirdParty = false,
          library = vim.api.nvim_get_runtime_file("", true),
        },
      },
    },
  }))
end

return M
