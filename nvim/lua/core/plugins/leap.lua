M = {
  'ggandor/leap.nvim',
  dependencies = {
    'tpope/vim-repeat'
  },
  config = function()
    vim.keymap.set({ 'n', 'v' }, 'f', "<plug>(leap-forward-to)", { remap = true })
    vim.keymap.set({ 'n', 'v' }, 't', "<plug>(leap-forward-till)", { remap = true })
    vim.keymap.set({ 'n', 'v' }, 'F', "<plug>(leap-backward-to)", { remap = true })
    vim.keymap.set({ 'n', 'v' }, 'T', "<plug>(leap-backward-till)", { remap = true })
  end
}

return M

