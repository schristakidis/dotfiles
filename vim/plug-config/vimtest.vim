nmap <silent> <leader>tt :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>ta :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>tg :TestVisit<CR>
let test#strategy = "vimux"
let test#python#runner = 'pytest'
" let test#python#pytest#options = '-s'

"vimux
map <Leader>tr :call VimuxRunCommand("clear; trial " . expand("%:p"))<CR>
map <Leader>trl :call VimuxRunCommand("!! \n")<CR>
