local conform = require("conform")

conform.setup({
  formatters_by_ft = {
    lua = { "stylua" },
    typescript = { "prettier" },
    css = { "prettier" },
    html = { "prettier" },
    sql = {
      formatCommand = "sql-formatter",
      formatStdin = true,
    },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
})

-- SI DESEAS QUE TODO UN ARCHIVO SE FORMATEE AL GUARDARLO, DESCOMENTA ESTE COMENTARIO
-- Opcional: Autocomando para formato automático al guardar
-- vim.api.nvim_create_autocmd("BufWritePre", {
--   pattern = "*",
--   callback = function()
--     conform.format({ lsp_fallback = true })
--   end,
-- })
