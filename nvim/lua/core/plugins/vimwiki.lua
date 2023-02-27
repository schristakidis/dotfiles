M = {
  'vimwiki/vimwiki',
  keys = {'<leader>ww'},
  init = function ()
    vim.cmd([[let g:vimwiki_ext2syntax = {'.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}]])
    vim.cmd([[let g:vimwiki_list = [{'path': '~/.dotfiles/wiki/', 'syntax': 'markdown', 'ext': '.md'}] ]])
    vim.g.vimwiki_global_ext = 0
  end
}

return M
