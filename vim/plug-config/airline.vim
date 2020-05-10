function! AirlineInit()
    let g:airline_section_z = airline#section#create(['%1p%%', '  ', 'linenr', ':%v'])
    let g:airline_symbols.linenr = ''
endfunction
autocmd User AirlineAfterInit call AirlineInit()

let g:airline_powerline_fonts = 1 
let g:airline_theme='powerlineish'
let g:airline_theme='oceanicnext'

let g:airline_skip_empty_sections = 1
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'

let g:airline#extensions#hunks#non_zero_only = 1
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#vista#enabled = 1
let g:airline#extensions#virtualenv#enabled = 1
let g:airline#extensions#wordcount#enabled = 0
let g:airline#extensions#ale#enabled = 1
