local pylsp_settings = {
  pylsp = {
    configurationSources = { "pycodestyle" },
    plugins = {
      jedi_completion = {
        enabled = false
      },
      jedi_definition = {
        enabled = false
      },
      jedi_hover = {
        enabled = false
      },
      jedi_references = {
        enabled = false
      },
      jedi_signature_help = {
        enabled = false
      },
      jedi_symbols = {
        enabled = false
      },
      mccabe = {
        enabled = false
      },
      pycodestyle = {
        enabled = true
      },
      pyflakes = {
        enabled = false
      },
      pylint = {
        enabled = false
      },
      rope_completion = {
        enabled = false
      },
      yapf = {
        enabled = false
      }
    }
  }
}

local pylsp_settings2 = {
  pylsp = {
    configurationSources = { "pycodestyle" },
    plugins = {
      jedi_completion = {
        enabled = true
      },
      jedi_definition = {
        enabled = true
      },
      jedi_hover = {
        enabled = true
      },
      jedi_references = {
        enabled = true
      },
      jedi_signature_help = {
        enabled = true
      },
      jedi_symbols = {
        enabled = true
      },
      mccabe = {
        enabled = false
      },
      pycodestyle = {
        enabled = true
      },
      pyflakes = {
        enabled = true
      },
      pylint = {
        enabled = false
      },
      rope_completion = {
        enabled = false
      },
      yapf = {
        enabled = false
      }
    }
  }
}


local function is_python2()
  local version = vim.api.nvim_exec([[echo system('python -V')]], true)
  if string.find(version, "Python 2.") then
    return true
  else
    return false
  end
end


local settings = pylsp_settings

if is_python2() then
  settings = pylsp_settings2
end

return {
  cmd = { 'pylsp' },
  filetypes = { 'python' },
  root_markers = {
    'pyproject.toml',
    'setup.py',
    'setup.cfg',
    'requirements.txt',
    'Pipfile',
    '.git',
  },
  settings = settings
}
