let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
" let g:vista_default_executive = 'coc'
let g:vista#renderer#enable_icon = 1

autocmd FileType vista,vista_kind nnoremap <buffer> <silent> \  :<c-u>call vista#finder#fzf#Run()<CR>

nmap <F8> :Vista!!<CR>

