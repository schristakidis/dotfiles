local gl = require('galaxyline')
local gls = gl.section
local extension = require('galaxyline.provider_extensions')
local util = require 'lspconfig/util'

gl.short_line_list = {
    'LuaTree',
    'vista',
    'dbui',
    'startify',
    'term',
    'nerdtree',
    'fugitive',
    'fugitiveblame',
    'plug',
    'minibufexpl'
}

local colors = {
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
    blue = '#51afef';
    red = '#ec5f67'
}

local icons = {
    locker = '', -- f023
    not_modifiable = '', -- f05e
    unsaved = '', -- f0c7
    pencil = '', -- f040
    dos = '', -- e70f
    unix = '', -- f17c
    mac = '', -- f179
    page = '☰', -- 2630
    line_number = '', -- e0a1
    connected = '', -- f817
    disconnected = '', -- f818
    error = '', -- f658
    warning = '', -- f06a
    info = '', -- f05a
    virtualenv = '🐍',
    git = '',
    git_add = ' ',
    git_modified = ' ',
    git_remove = ' ',
    trail_whitespaces = '  ',
    diagnostic_error = '  ',
    diagnostic_warning = '  ',
    diagnostic_hint = '  ',
}


local buffer_not_empty = function()
    if vim.fn.empty(vim.fn.expand('%:t')) ~= 1 then
        return true
    end
    return false
end

local checkwidth = function()
    local squeeze_width  = vim.fn.winwidth(0) / 2
    if squeeze_width > 40 then
        return true
    end
    return false
end


local get_file_path = function()
    local fname
    local file_path
    local project_root

    if not buffer_not_empty() then return '' end

    file_path = vim.fn.expand '%:p'
    project_root = util.find_git_ancestor(file_path)
    if project_root then
        fname = vim.fn.fnamemodify(file_path, ':s?' .. project_root .. '/??')
    else
        fname = vim.fn.fnamemodify(vim.fn.expand '%:p', ':~')
    end

    if not checkwidth() then
        fname = vim.fn.pathshorten(fname)
    end

    if #fname == 0 then return '' end
    if vim.bo.readonly then
        fname = fname .. ' ' .. icons.locker
    end
    if vim.bo.modified then
        fname = fname .. ' ' .. icons.unsaved
    end
    return ' ' .. fname .. ' '
end


local get_file_path_short_line = function()
    if not buffer_not_empty() then return '' end
    local fname
    fname = vim.fn.expand '%:t'

    if fname == '-MiniBufExplorer-' then
        return ''
    end

    fname = vim.fn.fnamemodify(vim.fn.expand '%:p', ':~')

    if #fname == 0 then return '' end
    if vim.bo.readonly then
        fname = fname .. ' ' .. icons.locker
    end
    if vim.bo.modified then
        fname = fname .. ' ' .. icons.unsaved
    end
    return ' ' .. fname .. ' '
end

local function get_virtual_env()
    local venv = vim.env.VIRTUAL_ENV:match("^.+/(.+)$")
    if not venv then return end
    return venv ..' '
end

local function get_current_func()
    local func_name = vim.api.nvim_eval('nvim_treesitter#statusline(90)')
    if not func_name then return end
    return func_name
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


local function get_filetype()
    local f_type = vim.bo.filetype
    if not f_type or f_type == '' then return end
    return f_type
end

local function icon_file_format()
    local icon = icons[vim.bo.fileformat] or ''
    return string.format(' %s  ', icon)
    -- return string.format('  %s (%s) ', icon, vim.bo.fileencoding)
end


local function trailing_whitespace()
    local trail = vim.fn.search("\\s$", "nw")
    if trail ~= 0 then
        return ' '
    else
        return nil
    end
end

CurrentFunc = get_current_func
TrailingWhiteSpace = trailing_whitespace

local function has_file_type()
    local f_type = vim.bo.filetype
    if not f_type or f_type == '' then
        return false
    end
    return true
end

local checkwidth_middle = function()
        local squeeze_width  = vim.fn.winwidth(0) / 2
        if squeeze_width > 80 then
                return true
        end
        return false
end

gls.left = {
    {
        FirstElement = {
            provider = function() return ' ' end,
            highlight = {colors.blue,colors.line_bg}
        },
    }, {
        ViMode = {
            provider = function()
                -- auto change color according the vim mode
                local alias = {
                    n = 'NORMAL',
                    i = 'INSERT',
                    c= 'COMMAND',
                    V= 'VISUAL',
                    [''] = 'VISUAL',
                    v ='VISUAL',
                    c  = 'COMMAND-LINE',
                    ['r?'] = ':CONFIRM',
                    rm = '--MORE',
                    R  = 'REPLACE',
                    Rv = 'VIRTUAL',
                    s  = 'SELECT',
                    S  = 'SELECT',
                    ['r']  = 'HIT-ENTER',
                    [''] = 'SELECT',
                    t  = 'TERMINAL',
                    ['!']  = 'SHELL',
                }
                local mode_color = {
                    n = colors.green,
                    i = colors.blue,v=colors.magenta,[''] = colors.magenta,V=colors.magenta,
                    c = colors.red,no = colors.magenta,s = colors.orange,S=colors.orange,
                    [''] = colors.orange,ic = colors.yellow,R = colors.purple,Rv = colors.purple,
                    cv = colors.red,ce=colors.red, r = colors.cyan,rm = colors.cyan, ['r?'] = colors.cyan,
                    ['!']  = colors.green,t = colors.green,
                    c  = colors.purple,
                    ['r?'] = colors.red,
                    ['r']  = colors.red,
                    rm = colors.red,
                    R  = colors.yellow,
                    Rv = colors.magenta,
                }
                local vim_mode = vim.fn.mode()
                vim.api.nvim_command('hi GalaxyViMode guifg='..mode_color[vim_mode])
                return alias[vim_mode] .. '   '
            end,
            highlight = {colors.red,colors.line_bg,'bold'},
        }
    }, {
        FileIcon = {
            provider = 'FileIcon',
            condition = buffer_not_empty,
            highlight = {require('galaxyline.provider_fileinfo').get_file_icon_color,colors.line_bg},
        }
    }, {
        FileName = {
            provider = get_file_path,
            condition = buffer_not_empty,
            highlight = {colors.fg,colors.line_bg,'bold'}
        }
    }, {
        VirtuelEnv = {
            provider = get_virtual_env,
            condition = has_virtualenv,
            icon = ' ' .. icons.virtualenv .. ' ',
            highlight = {colors.cyan,colors.line_bg}
        }
    }, {
        GitIcon = {
            provider = function() return ' ' .. icons.git .. ' ' end,
            condition = require('galaxyline.provider_vcs').get_git_branch,
            highlight = {colors.orange,colors.line_bg},
        }
    }, {
        GitBranch = {
            provider = 'GitBranch',
            condition = require('galaxyline.provider_vcs').get_git_branch,
            highlight = {'#8FBCBB',colors.line_bg,'bold'},
        }
    }, {
        SpaceC = {
            provider = function () return ' ' end,
            highlight = {colors.fg,colors.line_bg}
        }
    }, {
        DiffAdd = {
            provider = 'DiffAdd',
            condition = checkwidth,
            icon = icons.git_add,
            highlight = {colors.green,colors.line_bg},
        }
    }, {
        DiffModified = {
            provider = 'DiffModified',
            condition = checkwidth,
            icon = icons.git_modified,
            highlight = {colors.orange,colors.line_bg},
        }
    }, {
        DiffRemove = {
            provider = 'DiffRemove',
            condition = checkwidth,
            icon = icons.git_remove,
            highlight = {colors.red,colors.line_bg},
        }
    }, {
        LeftEnd = {
            provider = function() return '' end,
            separator = '',
            separator_highlight = {colors.bg,colors.line_bg},
            highlight = {colors.line_bg,colors.line_bg}
        }
    }, {
        TrailingWhiteSpace = {
            provider = TrailingWhiteSpace,
            icon = icons.trail_whitespaces,
            highlight = {colors.yellow,colors.bg},
        }
    }, {
        DiagnosticError = {
            provider = 'DiagnosticError',
            icon = icons.diagnostic_error,
            highlight = {colors.red,colors.bg}
        }
    }, {
        Space = {
            provider = function () return ' ' end
        }
    }, {
        DiagnosticWarn = {
            provider = 'DiagnosticWarn',
            icon = icons.diagnostic_warning,
            highlight = {colors.yellow,colors.bg},
        }
    }, {
        Space = {
            provider = function () return ' ' end
        }
    }, {
        DiagnosticHint = {
            provider = 'DiagnosticHint',
            icon = icons.diagnostic_hint,
            highlight = {colors.cyan,colors.bg},
        }
    }, {
        CurrentFunc = {
            provider = get_current_func,
            condition = checkwidth_middle,
            icon = '  λ ',
            highlight = {colors.yellow,colors.bg},
        }
    }
}

gls.right = {
    {
        IconFileFormat = {
            provider = icon_file_format,
            condition = buffer_not_empty,
            separator = ' ',
            separator_highlight = {colors.bg,colors.line_bg},
            highlight = {colors.fg,colors.line_bg}
        }
    }, {
        CustomBufferType = {
            provider = get_filetype,
            condition = has_file_type,
            highlight = {colors.fg,colors.line_bg}
        }
    }, {
        LineInfo = {
            provider = 'LineColumn',
            icon = '  ' .. icons.line_number .. ' ',
            highlight = {colors.fg,colors.line_bg}
        },
    }, {
        PerCent = {
            provider = 'LinePercent',
            separator = ' ',
            separator_highlight = {colors.line_bg,colors.line_bg},
            highlight = {colors.cyan,colors.darkblue,'bold'},
        }
    }
}

gls.short_line_left[1] = {
    BufferType = {
        provider = 'FileTypeName',
        separator = '',
        condition = has_file_type,
        separator_highlight = {colors.purple,colors.bg},
        highlight = {colors.fg,colors.purple}
    }
}
gls.short_line_left[2] = {
    FilePath = {
        provider = get_file_path_short_line,
        condition = buffer_not_empty,
        highlight = {colors.fg,colors.line_bg,'bold'}
    }
}


gls.short_line_right[1] = {
    BufferIcon = {
        provider = icon_file_format,
        separator = '',
        condition = has_file_type,
        separator_highlight = {colors.purple,colors.bg},
        highlight = {colors.fg,colors.purple}
    }
}

