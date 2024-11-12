-- Función para habilitar Codeium
function EnableCodeium()
  vim.g.codeium_enabled = true
  require("codeium").setup {
    keymap = {
      accept = "<C-Space>",
    }
  }
  print("Codeium habilitado")
end

-- Función para deshabilitar Codeium
function DisableCodeium()
  vim.g.codeium_enabled = false
  -- Aquí puedes limpiar cualquier configuración específica de Codeium si es necesario
  vim.cmd([[augroup CodeiumDisable]]) 
  vim.cmd([[autocmd!]]) 
  vim.cmd([[augroup END]])
  print("Codeium deshabilitado")
end

--:verbose map <leader>d- Mapear teclas para habilitar y deshabilitar Codeium
vim.api.nvim_set_keymap("n", "<Space>c", ":lua EnableCodeium()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Space>d", ":lua DisableCodeium()<CR>", { noremap = true, silent = true })


vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "
vim.opt.mouse = "a"
vim.opt.wrap = false
vim.opt.sidescroll = 5
vim.opt.sidescrolloff = 15  -- Ajusta la cantidad de columnas de margen lateral
vim.opt.scrolloff = 8  -- Mantiene siempre una línea visible por encima y por debajo del cursor
vim.opt.sidescrolloff = 8  -- Mantiene siempre 8 columnas visibles a la izquierda y derecha


vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = function()
    local max_line_length = 80 -- Ajusta este número según tu preferencia
    local current_buffer = vim.api.nvim_get_current_buf()
    local line_count = vim.api.nvim_buf_line_count(current_buffer)

    for i = 1, line_count do
      local line_length = vim.api.nvim_strwidth(vim.api.nvim_buf_get_lines(current_buffer, i - 1, i, false)[1])
      if line_length > max_line_length then
        vim.opt.sidescroll = line_length - max_line_length
        break
      else
        vim.opt.sidescroll = 5 -- Restablece a un valor predeterminado si no hay líneas largas
      end
    end
  end,
})

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "nvchad.autocmds"
require("configs.cmp") 

vim.schedule(function()
  require "mappings"
end)


