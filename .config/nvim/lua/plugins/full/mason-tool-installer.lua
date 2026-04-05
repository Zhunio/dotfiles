local function executable(bin)
  return vim.fn.executable(bin) == 1
end

return {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  opts = function()
    local ensure_installed = { "lua_ls", "stylua" }

    local has_node = executable("node") == 1
    local has_python = executable("python3") == 1 or executable("python") == 1
    local has_java = executable("java") == 1

    if has_node then
      vim.list_extend(ensure_installed, {
        "angularls",
        "cssls",
        "emmet_language_server",
        "html",
        "js-debug-adapter",
        "prettier",
        "pyright",
        "ts_ls",
      })
    end

    if has_python then
      vim.list_extend(ensure_installed, { "black", "isort" })
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

    return { ensure_installed = ensure_installed }
  end,
}
