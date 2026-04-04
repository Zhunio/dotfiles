local M = {}

function M.setup(on_attach)
  vim.lsp.config("ts_ls", vim.tbl_deep_extend("force", { on_attach = on_attach }, {
    cmd = { "typescript-language-server", "--stdio" },
    on_attach = function(_, bufnr)
      on_attach(_, bufnr)
      vim.keymap.set("n", "gO", function()
        vim.lsp.buf.execute_command({
          command = "_typescript.organizeImports",
          arguments = { vim.api.nvim_buf_get_name(bufnr) },
        })
      end, { buffer = bufnr, desc = "LSP: Organize Imports" })
    end,
    filetypes = {
      "javascript",
      "javascriptreact",
      "javascript.jsx",
      "typescript",
      "typescriptreact",
      "typescript.tsx",
    },
  }))
end

return M
