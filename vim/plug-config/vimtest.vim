nmap <silent> <leader>tt :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>ta :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>tg :TestVisit<CR>
let test#strategy = "vimux"
let test#python#runner = 'pytest'
let test#python#pytest#options = '-s'

"vimux
map <Leader>tr :call VimuxRunCommand("clear; trial " . expand("%:p"))<CR>
map <Leader>trl :call VimuxRunCommand("!! \n")<CR>

function! DPytestStrategy(cmd)
    let testName = split(a:cmd, '::')[1]
    call vimspector#LaunchWithSettings( #{ configuration: 'pytest', TestName: testName } )
endfunction

let g:test#custom_strategies = {'dpytest': function('DPytestStrategy')}

nmap <silent> <leader>td :TestNearest -strategy=dpytest<CR>
