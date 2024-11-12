-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "radium",
  --transparency = true, -- Cambia a true si quieres transparencia
  --theme_toggle = true; -- Cambia a true si quieres el cambio de temas
  hl_override = {
    Comment = { italic = true },
		["@comment"] = { italic = true },
    --Comment = { italic = true },
    String = { fg = "#98c379" }, -- Color para las cadenas
    Keyword = { fg = "#c678dd", bold = true }, -- Palabras clave en negrita
    --Function = { fg = "#61afef" }, -- Color para funciones
  },

  hl_add = {
    StatusLine = { bg = "#282c34", fg = "#61afef" },
    StatusLineNC = { bg = "#3e4451", fg = "#abb2bf" }, -- Color para líneas de estado no activas
    TabLine = { bg = "#3e4451", fg = "#abb2bf" }, -- Color de la línea de pestañas
  },
}

M.ui = {
  nvim_tree = {
    icons = {
      default = "",
      symlink = "",
      git = {
        unstaged = "✗",
        staged = "✓",
        unmerged = "",
        renamed = "➜",
        deleted = "",
        untracked = "★",
      },
    },
  },
}

return M
