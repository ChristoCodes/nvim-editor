return {

  {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup {
        automatic_installation = true, -- Activa la instalación automática
      }
    end,
  },

  {
    "SmiteshP/nvim-navic",
    dependencies = "neovim/nvim-lspconfig",
    config = function()
      require("nvim-navic").setup() -- Solo inicializa `nvim-navic` con su configuración predeterminada
    end,
  },


  {
    "Exafunction/codeium.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    event = "InsertEnter",
    config = function()
      require("codeium").setup {}
    end,
    lazy = false,
  },

  {
    "lewis6991/gitsigns.nvim",
    event = "BufRead",
    config = function()
      require("gitsigns").setup {
        signcolumn = true,
        attach_to_untracked = false,
        signs = {
          add = { text = "┃" },
          change = { text = "┃" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
          untracked = { text = "┆" },
        },
        signs_staged = {
          add = { text = "┃" },
          change = { text = "┃" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
          untracked = { text = "┆" },
        },
        signs_staged_enable = true,
        signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
        numhl = false,     -- Toggle with `:Gitsigns toggle_numhl`
        linehl = false,    -- Toggle with `:Gitsigns toggle_linehl`
        word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
        watch_gitdir = {
          follow_files = true,
        },
        auto_attach = true,
        attach_to_untracked = false,
        current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
          delay = 1000,
          ignore_whitespace = false,
          virt_text_priority = 100,
          use_focus = true,
        },
        current_line_blame_formatter = "<author>, <author_time:%R> - <summary>",
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil,  -- Use default
        max_file_length = 40000, -- Disable if file is longer than this (in lines)
        preview_config = {
          -- Options passed to nvim_open_win
          border = "single",
          style = "minimal",
          relative = "cursor",
          row = 0,
          col = 1,
        },
      }
      vim.api.nvim_set_keymap(
        "n",
        "<leader>hp",
        "<cmd>lua require'gitsigns'.preview_hunk()<CR>",
        { noremap = true, silent = true }
      )
    end,
  },

  -- Diffview.nvim
  {
    "sindrets/diffview.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("diffview").setup {
        enhanced_diff_hl = true, -- Mejora el resaltado de diferencias
        --use_icons = true, -- Muestra íconos
      }
    end,
  },

  {
    "dstein64/nvim-scrollview",
    event = "VeryLazy", -- Cambia esto para que se cargue en un momento posterior
    config = function()
      require("scrollview").setup {
        current_only = false,
        signs_on_scrollbar = false,
        excluded_filetypes = { "NvimTree", "vista_kind" },
        base = "window",
        scroll_speed = 9,
        signs_on = true,
        winblend = 45,
      }
    end,
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require "cmp"
      cmp.setup {
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        experimental = {
          ghost_text = true, -- Muestra un texto fantasma mientras seleccionas sugerencias
        },
        formatting = {
          fields = { "abbr", "kind", "menu" },
          format = function(entry, vim_item)
            -- Mostrar texto completo sin truncar
            vim_item.abbr = vim_item.abbr:sub(1, 1000) -- Ajusta el tamaño máximo si es necesario
            return vim_item
          end,
        },
        snippet = {

          expand = function(args)
            require("luasnip").lsp_expand(args.body) -- Usar LuaSnip para expandir snippets
          end,
        },
        mapping = {
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.close(),
          ["<CR>"] = cmp.mapping.confirm { select = true },

          -- Cambiar el comportamiento de la tecla Tab
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback() -- Permite que la tecla Tab funcione como de costumbre
            end
          end, { "i", "s" }),

          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback() -- Permite que Shift + Tab funcione como de costumbre
            end
          end, { "i", "s" }),
        },
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          {
            name = "codeium",
            max_item_count = 9,
            option = {
              max_len = 1000,
              max_lines = 20,
            },
          },
        }, {
          { name = "buffer" },
        }),
      }
    end,
  },
  {
    "folke/trouble.nvim",                             -- Agrega trouble.nvim
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- Asegúrate de tener esto también
    config = function()
      require("trouble").setup {
        -- Aquí puedes agregar opciones de configuración
        --icons = true, -- Mostrar íconos
        height = 40, -- Altura de la ventana de Trouble
        -- Otras opciones de configuración...
      }
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      require("nvim-tree").setup {
        view = {
          --width = 15, -- Aumenta el ancho del explorador
          adaptive_size = true,
          side = "left",
        },
        renderer = {
          group_empty = true,
          special_files = { "Makefile", "README.md", "readme.md", "*.csproj" }, -- Asegúrate de incluir .csproj aquí
          icons = {
            --padding = " ",
            show = {
              file = true,
              folder = true,
              folder_arrow = true,
            },
            padding = "",
            glyphs = {
              --default = "",
              --symlink = "",
              folder = {
                arrow_closed = "▶", -- Flecha para carpetas colapsadas
                arrow_open = "▼", -- Flecha para carpetas abiertas
                default = " ", -- Carpeta predeterminada
                open = " ", -- Carpeta abierta
                empty = " ", -- Carpeta vacía
                empty_open = " ", -- Carpeta vacía abierta
                symlink = " ", -- Enlace simbólico
                symlink_open = " ",
              },
            },
          },
          --highlight_git = true,
          highlight_opened_files = "name",
        },
        filters = {
          dotfiles = false,
        },
      }
    end,
  },

  {
    "nvim-tree/nvim-web-devicons",
    config = function()
      local devicons = require "nvim-web-devicons"

      -- Iterar sobre los íconos y agregar un espacio al final
      local icons = devicons.get_icons()
      for ext, icon_data in pairs(icons) do
        -- Agregar un espacio a cada ícono
        icon_data.icon = icon_data.icon .. " "
      end

      -- Aplicar los íconos con espacio agregado
      devicons.setup {
        override = icons,
        default = true, -- Esto asegura que todos los archivos tengan un ícono predeterminado
      }
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    requires = { "nvim-tree/nvim-web-devicons", opt = true },
    config = function()
      require("lualine").setup {
        options = {
          --theme = "material-darker",
          --icons_enabled = true,
          --component_separators = "|", -- Separadores entre los componentes
          --section_separators = { left = "", right = "" }, -- Cambia los separadores de sección
          always_divide_middle = true, -- Asegúrate de que la línea de estado ocupe todo el ancho
          global_status = true,
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff" },
          lualine_c = { "filename" },
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { "location" },
          lualine_z = { "progress", "lineinfo" },
        },
      }
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup {
        ensure_installed = { "lua", "javascript", "typescript", "html", "css", "python", "c_sharp" }, -- Añade los lenguajes que quieras
        highlight = {
          enable = true,                                                                              -- Activa el resaltado de sintaxis basado en Treesitter
          additional_vim_regex_highlighting = false,                                                  -- Desactiva el resaltado predeterminado de Vim
        },
      }
    end,
  },
}
