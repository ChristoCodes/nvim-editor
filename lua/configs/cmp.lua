-- ~/.config/nvim/lua/configs/cmp.lua
local cmp = require('cmp')
cmp.setup({
    sources = {
        { name = 'codeium' },  -- Agrega Codeium como fuente de autocompletado
        -- Agrega aquí otras fuentes si las tienes (por ejemplo, buffer, path, etc.)
    },
    -- Aquí puedes añadir más configuraciones para nvim-cmp si lo necesitas
})

