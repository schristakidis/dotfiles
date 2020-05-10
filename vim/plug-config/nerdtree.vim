map <Leader>nt :NERDTreeToggle<CR>
augroup nerdtree
    autocmd!
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
augroup END

