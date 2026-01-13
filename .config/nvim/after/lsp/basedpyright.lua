---@brief
---
--- https://detachhead.github.io/basedpyright
---
--- `basedpyright`, a static type checker and language server for python

local function is_python2()
  local version = vim.api.nvim_exec([[echo system('python -V')]], true)
  if string.find(version, "Python 2.") then
    return true
  else
    return false
  end
end

local function set_python_path(command)
  local path = command.args
  local clients = vim.lsp.get_clients {
    bufnr = vim.api.nvim_get_current_buf(),
    name = 'basedpyright',
  }
  for _, client in ipairs(clients) do
    if client.settings then
      ---@diagnostic disable-next-line: param-type-mismatch
      client.settings.python = vim.tbl_deep_extend('force', client.settings.python or {}, { pythonPath = path })
    else
      client.config.settings = vim.tbl_deep_extend('force', client.config.settings, { python = { pythonPath = path } })
    end
    client:notify('workspace/didChangeConfiguration', { settings = nil })
  end
end

local filetypes = { 'python' }
if is_python2() then
  filetypes = { 'nope' }
end

---@type vim.lsp.Config
return {
  cmd = { 'basedpyright-langserver', '--stdio' },
  filetypes = filetypes,
  root_markers = {
    'pyrightconfig.json',
    'pyproject.toml',
    'setup.py',
    'setup.cfg',
    'requirements.txt',
    'Pipfile',
    '.git',
  },
  settings = {
    basedpyright = {
      disableOrganizeImports = true,
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        -- diagnosticMode = 'openFilesOnly',
        diagnosticMode = "workspace",
        inlayHints = {
          variableTypes = false,
          functionReturnTypes = false,
          genericTypes = false
        },
        typeCheckingMode = "basic",
          diagnosticSeverityOverrides = {
            reportGeneralTypeIssues = "none",
            reportOptionalMemberAccess = "none",
            reportOptionalOperand = "none",
            reportOptionalSubscript = "none",
            reportOptionalIterable = "none",
          }
      },
    },
  },
  on_attach = function(client, bufnr)
    -- vim.api.nvim_buf_create_user_command(bufnr, 'LspPyrightOrganizeImports', function()
    --   local params = {
    --     command = 'basedpyright.organizeimports',
    --     arguments = { vim.uri_from_bufnr(bufnr) },
    --   }
    --
    --   -- Using client.request() directly because "basedpyright.organizeimports" is private
    --   -- (not advertised via capabilities), which client:exec_cmd() refuses to call.
    --   -- https://github.com/neovim/neovim/blob/c333d64663d3b6e0dd9aa440e433d346af4a3d81/runtime/lua/vim/lsp/client.lua#L1024-L1030
    --   ---@diagnostic disable-next-line: param-type-mismatch
    --   client.request('workspace/executeCommand', params, nil, bufnr)
    -- end, {
    --   desc = 'Organize Imports',
    -- })

    vim.api.nvim_buf_create_user_command(bufnr, 'LspPyrightSetPythonPath', set_python_path, {
      desc = 'Reconfigure basedpyright with the provided python path',
      nargs = 1,
      complete = 'file',
    })
  end,
}
