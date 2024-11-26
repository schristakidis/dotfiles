-- Run with :lua require('user.additional-schemas').init()
local curl = require 'plenary.curl'
local M = {
  schemas_catalog = 'datreeio/CRDs-catalog',
  schema_catalog_branch = 'main',
  github_base_api_url = 'https://api.github.com/repos',
  github_headers = {
    Accept = 'application/vnd.github+json',
    ['X-GitHub-Api-Version'] = '2022-11-28',
  },
}
M.schema_url = 'https://raw.githubusercontent.com/' .. M.schemas_catalog .. '/' .. M.schema_catalog_branch

M.list_github_tree = function()
  local url = M.github_base_api_url .. '/' .. M.schemas_catalog .. '/git/trees/' .. M.schema_catalog_branch
  local response = curl.get(url, { headers = M.github_headers, query = { recursive = 1 } })
  local body = vim.fn.json_decode(response.body)
  local trees = {}
  for _, tree in ipairs(body.tree) do
    if tree.type == 'blob' and tree.path:match '%.json$' then
      table.insert(trees, tree.path)
    end
  end
  return trees
end

M.init = function()
  local all_crds = M.list_github_tree()
  vim.ui.select(all_crds, { prompt = 'Select schema: ' }, function(selection)
    if not selection then
      require('user.utils').pretty_print 'Canceled.'
      return
    end
    local schema_url = M.schema_url .. '/' .. selection
    local schema_modeline = '# yaml-language-server: $schema=' .. schema_url
    -- vim.api.nvim_buf_set_lines(0, row-1, row, false, { schema_modeline })
    vim.api.nvim_put({ schema_modeline}, "l", false, false)
    -- vim.notify('Added schema modeline: ' .. schema_modeline)
  end)
end

M.init_advanced = function()
  local current_line = vim.api.nvim_get_current_line()
  local row, _ = unpack(vim.api.nvim_win_get_cursor(0))

  -- local api_version = vim.call('expand','<cWORD>')
  local api_version = string.gsub(current_line, 'apiVersion: ', '')
  local major = api_version:gsub('/.*', '')
  local version = api_version:gsub('.*/', '')
  local next_line = vim.api.nvim_buf_get_lines(0, row, row+1, false)[1]
  local kind = string.lower(next_line:gsub('kind: ', ''))
  local schema = major .. '/' .. kind .. '_' .. version .. '.json'
  local schema_url = M.schema_url .. '/' .. schema
  local schema_modeline = '# yaml-language-server: $schema=' .. schema_url
  vim.api.nvim_put({ schema_modeline}, "l", false, false)
end
return M
