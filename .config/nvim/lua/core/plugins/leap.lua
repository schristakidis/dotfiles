M = {
  'ggandor/leap.nvim',
  dependencies = {
    'tpope/vim-repeat'
  },
  config = function()
    vim.keymap.set({ 'n', 'v' }, '<localleader>f', "<plug>(leap-forward-to)", { remap = true })
    -- vim.keymap.set({ 'n', 'v' }, '<localleader>t', "<plug>(leap-forward-till)", { remap = true })
    vim.keymap.set({ 'n', 'v' }, '<localleader>F', "<plug>(leap-backward-to)", { remap = true })
    -- vim.keymap.set({ 'n', 'v' }, '<localleader>T', "<plug>(leap-backward-till)", { remap = true })
  end
}


return M
