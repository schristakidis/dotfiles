let g:vimwiki_ext2syntax = {'.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
let g:vimwiki_list = [{'path': '~/.dotfiles/wiki/', 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_global_ext = 0

nmap <leader>md :MarkdownPreview<CR>
nmap <leader>mc :MarkdownPreviewStop<CR>

