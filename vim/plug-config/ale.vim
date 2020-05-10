nmap <silent> <localleader>h <Plug>(ale_previous_wrap)
nmap <silent> <localleader>l <Plug>(ale_next_wrap)

let g:ale_linters = {'python': ['flake8'],}
let g:ale_type_map = {'flake8': {'ES': 'WS'}}
let g:ale_sign_error = '⤫'
let g:ale_sign_warning = '⚠'
let g:ale_sign_info = '--'
let g:ale_sign_style_error = '--'
let g:ale_sign_style_warning = '--'
let g:ale_echo_cursor = 1

