local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    typescript = { "prettier" },
    css = { "prettier" },
    html = { "prettier" },
    sql = {
      formatCommand = "sql-formatter",
      formatStdin = true
    }, 
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options
