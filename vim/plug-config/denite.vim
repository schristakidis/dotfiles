autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
    nnoremap <silent><buffer><expr> <CR>
                \ denite#do_map('do_action')
    nnoremap <silent><buffer><expr> p
                \ denite#do_map('do_action', 'preview')
    nnoremap <silent><buffer><expr> q
                \ denite#do_map('quit')
    nnoremap <silent><buffer><expr> <Esc>
                \ denite#do_map('quit')
    nnoremap <silent><buffer><expr> i
                \ denite#do_map('open_filter_buffer')
    nnoremap <silent><buffer><expr> v
                \ denite#do_map('do_action','vsplit' )
    nnoremap <silent><buffer><expr> <Space>
                \ denite#do_map('toggle_select').'j'
endfunction

autocmd FileType denite-filter call s:denite_filter_my_settings()
function! s:denite_filter_my_settings() abort
    " call deoplete#custom#buffer_option('auto_complete', v:false)

    imap <silent><buffer> <Esc>       <Plug>(denite_filter_quit)

    nnoremap <silent><buffer><expr> <Esc>
                \ denite#do_map('quit')

    inoremap <silent><buffer><expr> <C-v>
                \ denite#do_map('do_action','vsplit' )
    inoremap <silent><buffer><expr> <C-p>
                \ denite#do_map('do_action','preview' )

    inoremap <silent><buffer> <C-j>
                \ <Esc><C-w>p:call cursor(line('.')+1,0)<CR><C-w>pA
    inoremap <silent><buffer> <C-k>
                \ <Esc><C-w>p:call cursor(line('.')-1,0)<CR><C-w>pA
endfunction

call denite#custom#var('file/rec', 'command',
            \ ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])

" Change default action.
call denite#custom#kind('file', 'default_action', 'split')


" Ag command on grep source
call denite#custom#var('grep', 'command', ['ag'])
call denite#custom#var('grep', 'default_opts',
            \ ['-i', '--vimgrep'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', [])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])

" Define alias
call denite#custom#alias('source', 'file/rec/git', 'file/rec')
call denite#custom#var('file/rec/git', 'command',
            \ ['git', 'ls-files', '-co', '--exclude-standard'])

" Change ignore_globs
call denite#custom#filter('matcher/ignore_globs', 'ignore_globs',
            \ [ '.git/', '.ropeproject/', '__pycache__/',
            \   'venv/', 'images/', '*.min.*', 'img/', 'fonts/'])

call denite#custom#kind('file', 'default_action', 'open')

let s:menus = {}

let s:menus.dotfiles = {
            \ 'description': 'Edit your import zsh configuration'
            \ }
let s:menus.dotfiles.file_candidates = [
            \ ['zshrc', '~/.dotfiles/zsh/.zprezto/runcoms/zshrc'],
            \ ['zshenv', '~/.dotfiles/zsh/.zprezto/runcoms/zshenv'],
            \ ['vim', '~/.dotfiles/vim/vimrc'],
            \ ['nvim', '~/.config/nvim/init.vim'],
            \ ]
call denite#custom#var('menu', 'menus', s:menus)

" Custom options for Denite
"   auto_resize             - Auto resize the Denite window height automatically.
"   prompt                  - Customize denite prompt
"   direction               - Specify Denite window direction as directly below current pane
"   winminheight            - Specify min height for Denite window
"   highlight_mode_insert   - Specify h1-CursorLine in insert mode
"   prompt_highlight        - Specify color of prompt
"   highlight_matched_char  - Matched characters highlight
"   highlight_matched_range - matched range highlight

let s:denite_options = {'default' : {
            \ 'auto_resize': 1,
            \ 'source_names': 'short',
            \ 'prompt': 'λ ',
            \ 'highlight_matched_char': 'IncSearch',
            \ 'highlight_matched_range': 'Visual',
            \ 'highlight_window_background': 'Visual',
            \ 'highlight_filter_background': 'DiffAdd',
            \ 'winrow': 1,
            \ 'vertical_preview': 1
            \ }}

function! s:profile(opts) abort
    for l:fname in keys(a:opts)
        for l:dopt in keys(a:opts[l:fname])
            call denite#custom#option(l:fname, l:dopt, a:opts[l:fname][l:dopt])
        endfor
    endfor
endfunction

call s:profile(s:denite_options)
" catch
"     echo 'Denite not installed. It should work after running :PlugInstall'
" endtry
"
nnoremap <silent> <C-p> :<C-u>DeniteProjectDir file/rec -start-filter <CR> " -split=floating<CR>
nnoremap <silent> <C-f> :<C-u>Denite file/rec -start-filter -split=floating<CR>
nnoremap <silent> <C-b> :<C-u>Denite buffer<CR>
nnoremap <silent> <C-g> :<C-u>DeniteProjectDir -no-empty grep:::<C-R><C-W><CR>
nnoremap <silent> <Leader>z :<C-u>Denite menu:dotfiles<CR>
nnoremap <silent> <Leader>/ :<C-u>Denite line -start-filter<CR>
nnoremap <silent> <Leader>\ :<C-u>DeniteProjectDir grep<CR>
" open next result of previous search
nnoremap <silent> <localleader>j :<C-u>Denite -resume -cursor-pos=+1 -immediately<CR> 
" resume previous search
nnoremap <silent> <localleader>J :<C-u>Denite -resume -cursor-pos=+1<CR>

" highlight link deniteMatchedChar WarningMsg
" highlight link deniteMatchedRange None
