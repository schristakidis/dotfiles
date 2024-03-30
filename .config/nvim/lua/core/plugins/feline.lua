local M = {
  'freddiehaddad/feline.nvim',
  dependencies = {
    'SmiteshP/nvim-gps'
  },
  config = function()
    local line_ok, feline = pcall(require, "feline")
    if not line_ok then
      return
    end

    local gps = require("nvim-gps")

    local icons = {
      virtualenv = '🐍',
    }

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

    local vi_mode_colors = {
      NORMAL = "green",
      OP = "green",
      INSERT = "yellow",
      VISUAL = "purple",
      LINES = "orange",
      BLOCK = "dark_red",
      REPLACE = "red",
      COMMAND = "aqua",
    }

    local function maximize_status()
      return vim.t.maximized and '   ' or ''
    end

    local function get_virtual_env()
      local venv = vim.env.VIRTUAL_ENV:match("^.+/(.+)$")
      if not venv then return end
      return venv .. ' '
    end

    local function is_python_filetype()
      local f_type = vim.bo.filetype
      if not f_type or f_type ~= 'python' then
        return false
      end
      return true
    end

    local function has_virtualenv()
      return is_python_filetype() and vim.env.VIRTUAL_ENV
    end

    local function get_schema()
      local schema = require("yaml-companion").get_buf_schema(0)
      if schema.result[1].name == "none" then
        return ""
      end
      return schema.result[1].name
    end

    local c = {
      vim_mode = {
        provider = {
          name = "vi_mode",
          opts = {
            show_mode_name = true,
          },
        },
        hl = function()
          return {
            fg = require("feline.providers.vi_mode").get_mode_color(),
            bg = "line_bg",
            style = "bold",
            name = "NeovimModeHLColor",
          }
        end,
        left_sep = "block",
        right_sep = "block",
        priority = 10
      },
      maximized = {
        provider = maximize_status,
        hl = {
          style = "bold",
          bg = "line_bg",
          fg = "cyan"
        },
      },
      fileinfo = {
        provider = {
          name = "file_info",
          opts = {
            type = "unique",
          },
        },
        short_provider = {
          name = "file_info",
          opts = {
            type = "unique-short",
          },
        },
        hl = {
          style = "bold",
          bg = "line_bg",
          fg = "cyan"
        },
        right_sep = {
          str = " ",
          hl = {
            bg = "line_bg",
          }
        },
        priority = 10
      },
      fileinfo_inactive = {
        provider = {
          name = "file_info",
          opts = {
            type = "relative",
          },
        },
        short_provider = {
          name = "file_info",
          opts = {
            type = "relative-short",
          },
        },
        hl = {
          style = "bold",
          bg = "line_bg",
          -- fg = "cyan"
        },
        right_sep = {
          str = " ",
          hl = {
            bg = "line_bg",
          }
        },
        priority = 10
      },
      gitBranch = {
        provider = "git_branch",
        enabled = require('feline.providers.git').git_info_exists,
        hl = {
          style = "bold",
          bg = "line_bg",
        },
        icon = {
          str = " ",
          hl = {
            bg = "line_bg",
            fg = "orange",
            style = "bold"
          },
          always_visible = true,
        },
        left_sep = {
          str = " ",
          hl = {
            bg = "line_bg",
          }

        },
        right_sep = {
          str = " ",
          hl = {
            bg = "line_bg",
          }
        },
        priority = 4,
        truncate_hide = true
      },
      gitDiffAdded = {
        provider = "git_diff_added",
        hl = {
          fg = "green",
          bg = "line_bg"
        },
        priority = 2,
        truncate_hide = true
      },
      gitDiffRemoved = {
        provider = "git_diff_removed",
        hl = {
          fg = "red",
          bg = "line_bg"
        },
        priority = 2,
        truncate_hide = true
      },
      gitDiffChanged = {
        provider = "git_diff_changed",
        hl = {
          fg = "orange",
          bg = "line_bg"
        },
        priority = 2,
        truncate_hide = true
      },
      separator = {
        provider = " ",
        right_sep = "slant_right",
        hl = {
          bg = "line_bg"
        },
      },
      inverse_separator = {
        provider = " ",
        left_sep = "slant_left",
        hl = {
          bg = "line_bg"
        },
      },
      diagnostic_errors = {
        provider = "diagnostic_errors",
        hl = {
          fg = "red",
        },
        priority = 3,
        truncate_hide = true
      },
      diagnostic_warnings = {
        provider = "diagnostic_warnings",
        hl = {
          fg = "yellow",
        },
        priority = 3,
        truncate_hide = true
      },
      diagnostic_hints = {
        provider = "diagnostic_hints",
        hl = {
          fg = "aqua",
        },
        priority = 2,
        truncate_hide = true
      },
      diagnostic_info = {
        provider = "diagnostic_info",
        right_sep = "block",
        priority = 2,
        truncate_hide = true
      },
      navic = {
        provider = function() return gps.get_location() end,
        enabled = function() return gps.is_available() end,
        truncate_hide = true,
      },
      lsp_client_names = {
        provider = "lsp_client_names",
        hl = {
          fg = "purple",
          bg = "darkblue",
          style = "bold",
        },
        left_sep = "left_filled",
        right_sep = "block",
        truncate_hide = true,
      },
      virtualenv = {
        provider = get_virtual_env,
        enabled = has_virtualenv,
        hl = {
          bg = "line_bg"
        },
        icon = {
          str = icons.virtualenv,
          hl = {
            fg = "orange"
          }
        },
        priority = 3,
        truncate_hide = true
      },
      schema = {
        provider = get_schema,
        hl = {
          bg = "line_bg"
        },
        -- icon = {
        --   str = icons.virtualenv,
        --   hl = {
        --     fg = "orange"
        --   }
        -- },
        priority = 3,
        truncate_hide = true
      },
      file_type = {
        provider = {
          name = "file_type",
          opts = {
            filetype_icon = true,
            case = "titlecase",
          },
        },
        hl = {
          -- fg = "red",
          -- bg = "darkblue",
          bg = "line_bg",
          style = "bold",
        },
        left_sep = "block",
        right_sep = "block",
        truncate_hide = true
      },
      file_encoding = {
        provider = "file_encoding",
        hl = {
          fg = "orange",
          bg = "darkblue",
          style = "italic",
        },
        left_sep = "block",
        right_sep = "block",
        truncate_hide = true
      },
      position = {
        provider = "position",
        hl = {
          fg = "green",
          bg = "line_bg",
          style = "bold",
        },
        left_sep = "block",
        right_sep = "block",
      },
      line_percentage = {
        provider = "line_percentage",
        hl = {
          fg = "aqua",
          bg = "line_bg",
          style = "bold",
        },
        left_sep = "block",
        right_sep = "block",
      },
      scroll_bar = {
        provider = "scroll_bar",
        hl = {
          fg = "yellow",
          style = "bold",
        },
      },
      file_format = {
        provider = "file_format",
        hl = {
          fg = "yellow",
          style = "bold",
        },
      },
    }

    local left = {
      c.vim_mode,
      c.maximized,
      c.fileinfo,
      c.gitBranch,
      c.gitDiffAdded,
      c.gitDiffRemoved,
      c.gitDiffChanged,
      c.separator,
      c.diagnostic_errors,
      c.diagnostic_warnings,
      c.diagnostic_info,
      c.diagnostic_hints,
    }

    local middle = {
      c.navic
    }

    local right = {
      c.inverse_separator,
      c.virtualenv,
      c.schema,
      c.file_type,
      c.position,
      c.line_percentage,
      c.scroll_bar,
    }

    local left_inactive = {
      -- c.fileinfo_inactive
    }

    local middle_inactive = {
      c.fileinfo_inactive
    }

    local right_inactive = {
      c.file_format
    }

    local components = {
      active = {
        left,
        middle,
        right,
      },
      inactive = {
        left_inactive,
        middle_inactive,
        right_inactive
      },
    }

    feline.setup({
      components = components,
      theme = onedark_colors,
      vi_mode_colors = vi_mode_colors,
    })
  end
}

return M
