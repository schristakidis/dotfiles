local pylsp_settings = {
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
        enabled = false
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

local filetypes = { 'python' }
if not is_python2() then
  filetypes = { 'nope' }
end

return {
  cmd = { 'pylsp' },
  filetypes = filetypes,
  root_markers = {
    'pyproject.toml',
    'setup.py',
    'setup.cfg',
    'requirements.txt',
    'Pipfile',
    '.git',
  },
  settings = pylsp_settings
}
