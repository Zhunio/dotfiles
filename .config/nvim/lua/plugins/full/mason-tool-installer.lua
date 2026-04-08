local function executable(bin)
  return vim.fn.executable(bin) == 1
end

return {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  config = function()
    local ensure_installed = { "lua_ls", "stylua" }

    local has_node = executable("node")
    local has_python = executable("python3") or executable("python")
    local has_java = executable("java")

    if has_node then
      vim.list_extend(ensure_installed, {
        "angular-language-server",
        "css-lsp",
        "emmet-language-server",
        "html-lsp",
        "js-debug-adapter",
        "prettier",
        "typescript-language-server",
      })
    end

    if has_python then
      vim.list_extend(ensure_installed, { "black", "isort", "pyright" })
    end

    if has_java then
      vim.list_extend(ensure_installed, {
        "google-java-format",
        "java-debug-adapter",
        "java-test",
        "jdtls",
        "xmlformatter",
      })
    end

    require("mason-tool-installer").setup({
      ensure_installed = ensure_installed,
    })
  end,
}
