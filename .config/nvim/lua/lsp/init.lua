local M = {}

local function executable(bin)
  return vim.fn.executable(bin) == 1
end

local function has_python()
  return executable("python3") == 1 or executable("python") == 1
end

local function has_node()
  return executable("node") == 1
end

local function has_java()
  return executable("java") == 1
end

function M.ensure_installed()
  local tools = { "lua_ls", "stylua" }

  if has_node() then
    vim.list_extend(tools, {
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

  if has_python() then
    vim.list_extend(tools, { "black", "isort" })
  end

  if has_java() then
    vim.list_extend(tools, {
      "google-java-format",
      "java-debug-adapter",
      "java-test",
      "jdtls",
      "xmlformatter",
    })
  end

  return tools
end

function M.setup(on_attach)
  local modules = {
    { cond = function() return true end, setup = require("lsp.lua").setup },
    { cond = has_python, setup = require("lsp.python").setup },
    { cond = has_node, setup = require("lsp.angular").setup },
    { cond = has_node, setup = require("lsp.typescript").setup },
    { cond = has_java, setup = require("lsp.java").setup },
  }

  for _, mod in ipairs(modules) do
    if mod.cond() then
      mod.setup(on_attach)
    end
  end
end

return M
