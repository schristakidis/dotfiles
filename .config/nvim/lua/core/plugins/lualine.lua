local onedark_colors = {
  bg = '#282c34',
  line_bg = '#353644',
  fg = '#8FBCBB',
  fg_green = '#65a380',
  yellow = '#fabd2f',
  cyan = '#008080',
  darkblue = '#081633',
  green = '#afd700',
  orange = '#FF8800',
  purple = '#5d4d7a',
  magenta = '#c678dd',
  aqua = "#61afef",
  blue = '#51afef',
  red = '#ec5f67'
}

local colors = onedark_colors

local vi_mode_colors = {
  NORMAL = colors.green,
  OP = colors.green,
  INSERT = colors.yellow,
  VISUAL = colors.orange,
  LINES = colors.orange,
  BLOCK = colors.dark_red,
  REPLACE = colors.red,
  COMMAND = colors.blue,
}

local icons = {
  virtualenv = '󰌠',
}

local function maximize_status()
  return vim.t.maximized and '   ' or ''
end

local function is_python_filetype()
  local f_type = vim.bo.filetype
  if not f_type or f_type ~= 'python' then
    return false
  end
  return true
end

local function has_virtualenv()
  if is_python_filetype() and vim.env.VIRTUAL_ENV then return true end
  return false
end

local function get_virtual_env()
  local venv = vim.env.VIRTUAL_ENV:match("^.+/(.+)$")
  if not venv then return end
  return venv .. ' '
end

local config = {
  options = {
    theme = {
      normal = {
        a = { fg = vi_mode_colors.NORMAL, bg = colors.line_bg },
        b = { fg = colors.fg, bg = colors.line_bg },
        c = { fg = colors.fg, bg = colors.bg },
      },
      insert = { a = { fg = vi_mode_colors.INSERT, bg = colors.line_bg } },
      visual = { a = { fg = vi_mode_colors.VISUAL, bg = colors.line_bg } },
      replace = { a = { fg = vi_mode_colors.REPLACE, bg = colors.line_bg } },
      block = { a = { fg = vi_mode_colors.BLOCK, bg = colors.line_bg } },
      command = { a = { fg = vi_mode_colors.COMMAND, bg = colors.line_bg } },
      inactive = {
        a = { fg = colors.fg, bg = colors.line_bg },
        b = { fg = colors.fg, bg = colors.line_bg },
        c = { fg = colors.fg, bg = colors.line_bg },
      },
    },
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    disabled_filetypes = { 'alpha', 'dashboard', 'neo-tree', 'NvimTree' },
    ignore_focus = { 'alpha', 'dashboard', 'neo-tree', 'NvimTree' },
  },
  sections = {
    lualine_a = { { 'mode', icon = '' } },
    lualine_b = {
      {
        maximize_status,
        color = {
          gui = "bold",
          fg = colors.cyan
        },
        padding = 0
      },
      {
        'filetype',
        colored = true,
        icon_only = true,
        padding = {
          left = 1,
          right = 0,

        },
      },
      {
        'filename',
        padding = {
          left = 0,
          right = 1,

        },
        path = 1,
        symbols = {
          modified = '●',
          readonly = '[-]',
          unnamed = '[No Name]',
          newfile = '[New]',
        },
        color = {
          gui = "bold",
          bg = colors.line_bg,
          fg = colors.cyan
        },
      },
      {
        'branch',
        icon = {
          '',
          color = {
            gui = "bold",
            bg = colors.line_bg,
            fg = colors.orange
          },
        }
      },
      {
        'diff',
        colored = true,
        diff_color = {
          added    = { fg = colors.green, bg = colors.line_bg },
          modified = { fg = colors.orange, bg = colors.line_bg },
          removed  = { fg = colors.red, bg = colors.line_bg }
        },
        symbols = { added = ' ', modified = ' ', removed = ' ' }
      },
    },
    lualine_c = {
      {
        'diagnostics',
        -- sources = { 'nvim_lsp', 'nvim_diagnostic', 'nvim_workspace_diagnostic', 'coc', 'ale', 'vim_lsp'},
        sources = { 'nvim_diagnostic' },

        sections = { 'error', 'warn', 'info', 'hint' },
        color = {
          bg = colors.bg,
          gui = "none"
        },

        diagnostics_color = {
          error = { fg = colors.red },
          warn  = { fg = colors.yellow },
          info  = { fg = colors.aqua },
          hint  = { fg = colors.aqua }
        },
        symbols = { error = '  ', warn = '  ', info = '  ', hint = '  ' },
        colored = true,
        update_in_insert = false,
        always_visible = false,
      },
      { 'navic' }
    },
    lualine_x = {},
    lualine_y = {
      {
        get_virtual_env,
        cond = has_virtualenv,
        color = {
          bg = colors.line_bg
        },
        padding = 0,
        icon = {
          icons.virtualenv,
          color = {
            fg = colors.orange
          }
        },
      },
      {
        cond = function()
          return package.loaded["schema-companion"]
        end,
        function()
          return ("%s"):format(require("schema-companion.context").get_buffer_schema().name)
        end,
        color = {
          bg = colors.line_bg
        },
        padding = 0,
      },
      { 'filetype' },
      { 'location'}
    },
    lualine_z = { 'progress' }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { {'filename', path=4} },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  -- extensions = { 'neo-tree', 'lazyload', 'toggleterm' }
}


M = {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local lualine = require('lualine')
    lualine.setup(config)
  end
}

-- return {}

return M
