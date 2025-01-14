local lspconfig = require "lspconfig"
local nvlsp = require "nvchad.configs.lspconfig"
local navic = require "nvim-navic" -- Agrega esto para usar `nvim-navic`

-- Configuración específica para cada servidor
local servers = {
  lua_ls = { filetypes = { "lua" } },
  html = { filetypes = { "html", "htm" } },
  cssls = { filetypes = { "css", "scss", "less" } },
  ts_ls = {
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  },
  omnisharp = {
    filetypes = { "cs", "csproj" },
    cmd = {
      "dotnet",
      "/home/system/omnisharp/OmniSharp.dll",
    },
    settings = {
      FormattingOptions = {
        OrganizeImports = true,
        TrimTrailingWhitespace = true,
        EndOfLine = "lf",
      },
    },
  },
  sqlls = {
    filetypes = { "sql", "mysql" },
    cmd = {
      "sql-language-server",
      "up",
      "--method",
      "stdio",
    },
    root_dir = function()
      return vim.loop.cwd()
    end,
  },
}

-- Configuración de los servidores LSP
for lsp, config in pairs(servers) do
  local setup_config = {
    on_attach = function(client, bufnr)
      nvlsp.on_attach(client, bufnr)
      vim.cmd "autocmd CursorHold <buffer> lua vim.diagnostic.open_float(nil, { focusable = false })"

      -- Integrar `nvim-navic`
      if client.server_capabilities.documentSymbolProvider then
        navic.attach(client, bufnr)
      end
    end,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
    filetypes = config.filetypes,
  }

  -- Incluir el cmd solo para omnisharp y sqlls
  if lsp == "omnisharp" or lsp == "sqlls" then
    setup_config.cmd = config.cmd
  end

  -- Configurar el servidor
  lspconfig[lsp].setup(setup_config)
end

-- Configuración de diagnósticos
vim.diagnostic.config {
  virtual_text = {
    spacing = 4,
    prefix = "●",
  },
  signs = true,
  update_in_insert = true,
  underline = true,
  severity_sort = true,
}
