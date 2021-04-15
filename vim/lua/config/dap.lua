local dap = require('dap')
require('dap-python').setup('~/.virtualenvs/debugpy/bin/python',{
        include_configs = true,
        console = 'integratedTerminal'
})
require("dapui").setup()
require('telescope').load_extension('dap')

local opts = { noremap=false, silent=true }
local api = vim.api
local set_keymap = vim.api.nvim_set_keymap

require('dap-python').test_runner = 'pytest'
set_keymap('n', '<leader>dt', [[<Cmd>lua require('dap-python').test_method()<CR>]], opts)
set_keymap('n', '<leader>dc', [[<Cmd>lua require('dap-python').test_class()<CR>]], opts)
set_keymap('v', '<leader>ds <ESC>', [[<Cmd>lua require('dap-python').debug_selection()<CR>]], opts)

set_keymap('n', '<leader>dd', [[<Cmd>lua require('dap').continue()<CR>]], opts)
set_keymap('n', 'F5', [[<Cmd>lua require('dap').continue()<CR>]], opts)
set_keymap('n', '<leader>dv', [[<Cmd>lua require('dap').step_over()<CR>]], opts)
set_keymap('n', '<leader>di', [[<Cmd>lua require('dap').step_into()<CR>]], opts)
set_keymap('n', '<leader>do', [[<Cmd>lua require('dap').step_out()<CR>]], opts)
set_keymap('n', '<leader>b', [[<Cmd>lua require('dap').toggle_breakpoint()<CR>]], opts)
set_keymap('n', '<leader>B', [[<Cmd>lua require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>]], opts)
set_keymap('n', '<leader>dr', [[<Cmd>lua require('dap').repl.open()<CR>]], opts)
set_keymap('n', '<leader>dl', [[<Cmd>lua require('dap').repl.last()<CR>]], opts)

vim.fn.sign_define('DapBreakpoint', {text='🟥', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapStopped', {text='🟢', texthl='', linehl='', numhl=''})

local keymap_restore = {}
dap.listeners.after['event_initialized']['me'] = function()
    for _, buf in pairs(api.nvim_list_bufs()) do
        local keymaps = api.nvim_buf_get_keymap(buf, 'n')
        for _, keymap in pairs(keymaps) do
            if keymap.lhs == "K" then
                table.insert(keymap_restore, keymap)
                api.nvim_buf_del_keymap(buf, 'n', 'K')
            end
        end
    end
    api.nvim_set_keymap(
        'n', 'K', '<Cmd>lua require("dap.ui.variables").hover()<CR>', { silent = true })
end

dap.listeners.after['event_terminated']['me'] = function()
    for _, keymap in pairs(keymap_restore) do
        api.nvim_buf_set_keymap(
            keymap.buffer,
            keymap.mode,
            keymap.lhs,
            keymap.rhs,
            { silent = keymap.silent == 1 }
            )
    end
    keymap_restore = {}
end


local ultest_python = function(cmd)
  -- The command can start with python command directly or an env manager
  local non_modules = {'python', 'pipenv', 'poetry'}
  -- Index of the python module to run the test.
  local module
  if vim.tbl_contains(non_modules, cmd[1]) then
    module = cmd[3]
  else
    module = cmd[1]
  end
  -- Remaining elements are arguments to the module
  local args = vim.list_slice(cmd, 1)
  return {
    dap = {
      type = 'python',
      request = 'launch',
      module = module,
      args = args
    }
  }
end

require("ultest").setup({
        builders = {
            ['python#pytest'] = ultest_python
        }
    })
