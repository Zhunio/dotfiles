local lsp = require("lsp")

local function on_attach(_, bufnr)
  local opts = { buffer = bufnr }
  vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "LSP: Rename symbol" }))
  vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "LSP: Hover documentation" }))
end

return {
  {
    "williamboman/mason.nvim",
    opts = {
      ui = {
        icons = { package_installed = "✓", package_pending = "➜", package_uninstalled = "✗" },
      },
    },
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = function()
      return { ensure_installed = lsp.ensure_installed() }
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
      local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end

      vim.diagnostic.config({ virtual_text = true })

      lsp.setup(on_attach)
      require("mason-lspconfig").setup({})
    end,
  },
}
