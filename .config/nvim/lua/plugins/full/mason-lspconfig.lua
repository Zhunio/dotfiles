local function executable(bin)
  return vim.fn.executable(bin) == 1
end

local function on_attach(_, bufnr)
  local opts = { buffer = bufnr }
  vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "LSP: Rename symbol" }))
  vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "LSP: Hover documentation" }))
end

local function extend(config)
  return vim.tbl_deep_extend("force", { on_attach = on_attach }, config or {})
end

local function setup_lua()
  vim.lsp.config("lua_ls", extend({
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

local function setup_angular()
  vim.lsp.config("angularls", extend({
    root_dir = function(fname)
      local lspconfig = require("lspconfig")
      local root = lspconfig.util.root_pattern("angular.json", "workspace.json", "project.json")(fname)
      return root or nil
    end,
  }))
end

local function setup_typescript()
  vim.lsp.config("ts_ls", extend({
    cmd = { "typescript-language-server", "--stdio" },
    on_attach = function(_, bufnr)
      on_attach(_, bufnr)
      vim.keymap.set("n", "gO", function()
        local clients = vim.lsp.get_clients({ bufnr = bufnr, name = "ts_ls" })
        for _, client in ipairs(clients) do
          client:exec_cmd({
          title = "Organize Imports",
          command = "_typescript.organizeImports",
          arguments = { vim.api.nvim_buf_get_name(bufnr) },
          }, { bufnr = bufnr })
        end
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

local function get_jdtls_config_path()
  local system = vim.loop.os_uname().sysname
  local config_dir = ({
    Darwin = "config_mac",
    Linux = "config_linux",
    Windows_NT = "config_win",
  })[system] or "config_linux"

  return vim.fn.glob("$MASON/packages/jdtls/" .. config_dir)
end

local function get_jdtls_bundles()
  local bundles = {}
  local sources = {
    vim.fn.glob("$MASON/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar", nil, true),
    vim.fn.glob("$MASON/packages/java-test/extension/server/*.jar", nil, true),
  }
  local excluded_bundles = {
    "com.microsoft.java.test.runner-jar-with-dependencies.jar",
    "jacocoagent.jar",
  }

  for _, source in ipairs(sources) do
    vim.list_extend(bundles, source)
  end

  for i = #bundles, 1, -1 do
    local filename = vim.fn.fnamemodify(bundles[i], ":t")
    if vim.tbl_contains(excluded_bundles, filename) then
      table.remove(bundles, i)
    end
  end

  return bundles
end

local function get_jdtls_workspace(root_dir)
  local project_name = vim.fn.fnamemodify(root_dir, ":p:t")
  return vim.fn.stdpath("cache") .. "/jdtls-data/" .. project_name
end

local function get_jdtls_config(root_dir)
  local lombok_path = vim.fn.glob("$MASON/packages/jdtls/lombok.jar")
  local equinox_path = vim.fn.glob("$MASON/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar")
  local config_path = get_jdtls_config_path()

  return {
    cmd = {
      "java",
      "-Declipse.application=org.eclipse.jdt.ls.core.id1",
      "-Dosgi.bundles.defaultStartLevel=4",
      "-Declipse.product=org.eclipse.jdt.ls.core.product",
      "-Dlog.protocol=true",
      "-Dlog.level=ALL",
      "-javaagent:" .. lombok_path,
      "-Xmx1g",
      "--add-modules=ALL-SYSTEM",
      "--add-opens", "java.base/java.util=ALL-UNNAMED",
      "--add-opens", "java.base/java.lang=ALL-UNNAMED",
      "-jar", equinox_path,
      "-configuration", config_path,
      "-data", get_jdtls_workspace(root_dir),
    },
    on_attach = on_attach,
    root_dir = root_dir,
    settings = { java = {} },
    init_options = { bundles = get_jdtls_bundles() },
  }
end

return {
  {
    "mfussenegger/nvim-jdtls",
    ft = { "java" },
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "java",
        callback = function(args)
          local root_dir = vim.fs.root(args.buf, { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" })
          if not root_dir then
            return
          end

          local client = require("jdtls")
          client.start_or_attach(get_jdtls_config(root_dir))
          client.setup_dap({ hotcodereplace = "auto" })
        end,
      })
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
      local has_python = executable("python3") == 1 or executable("python") == 1
      local has_node = executable("node") == 1

      setup_lua()
      vim.lsp.enable("lua_ls")

      if has_python then
        vim.lsp.config("pyright", extend())
        vim.lsp.enable("pyright")
      end

      if has_node then
        setup_angular()
        vim.lsp.config("cssls", extend())
        vim.lsp.config("emmet_language_server", extend())
        vim.lsp.config("html", extend({
          filetypes = { "html" },
        }))
        setup_typescript()
        vim.lsp.enable("angularls")
        vim.lsp.enable("cssls")
        vim.lsp.enable("emmet_language_server")
        vim.lsp.enable("html")
        vim.lsp.enable("ts_ls")
      end

      require("mason-lspconfig").setup({})
    end,
  },
}
