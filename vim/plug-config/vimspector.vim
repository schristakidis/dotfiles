let g:vimspector_base_dir=expand('$HOME/.dotfiles/vim/vimspector-config')

fun! GotoWindow(id)
    call win_gotoid(a:id)
    MaximizerToggle
endfun

func! AddToWatch()
    let word = expand("<cexpr>")
    call vimspector#AddWatch(word)
endfunction

func! CloseDebugger()
    call vimspector#ClearBreakpoints()
    call vimspector#Reset()
    " call vimspector#Stop()
endfunction

" Custom mappings while debuggins {{{

" Debugger remaps
nnoremap <leader>dd :call vimspector#Launch()<CR>
nmap <LocalLeader>db <Plug>VimspectorToggleBreakpoint
nmap <LocalLeader>dB <Plug>VimspectorToggleConditionalBreakpoint

let s:mapped = {}

function! s:OnJumpToFrame() abort
    if has_key( s:mapped, string( bufnr() ) )
        return
    endif

    nnoremap <silent> <buffer> <leader>dc :call GotoWindow(g:vimspector_session_windows.code)<CR>
    nnoremap <silent> <buffer> <leader>dv :call GotoWindow(g:vimspector_session_windows.variables)<CR>
    nnoremap <silent> <buffer> <leader>dW :call GotoWindow(g:vimspector_session_windows.watches)<CR>
    nnoremap <silent> <buffer> <leader>ds :call GotoWindow(g:vimspector_session_windows.stack_trace)<CR>
    nnoremap <silent> <buffer> <leader>do :call GotoWindow(g:vimspector_session_windows.output)<CR>

    nnoremap <silent> <buffer> <leader>de :call CloseDebugger()<CR>
    nnoremap <silent> <buffer> <leader>dE :call vimspector#ClearBreakpoints()<CR>

    nnoremap <silent> <buffer> <LocalLeader>dw :call AddToWatch()<CR>

    nnoremap <silent> <buffer> <LocalLeader>dc :call vimspector#Continue()<CR>
    nmap <silent> <buffer> <LocalLeader>dh <Plug>VimspectorRunToCursor

    nmap <silent> <buffer> <LocalLeader>do <Plug>VimspectorStepOut
    nmap <silent> <buffer> <LocalLeader>dn <Plug>VimspectorStepInto
    nmap <silent> <buffer> <LocalLeader>df <Plug>VimspectorStepOver
    nmap <silent> <buffer> <LocalLeader>d_ <Plug>VimspectorRestart

    nmap <silent> <buffer> <LocalLeader>dc <Plug>VimspectorContinue
    nmap <silent> <buffer> <LocalLeader>di <Plug>VimspectorBalloonEval
    xmap <silent> <buffer> <LocalLeader>di <Plug>VimspectorBalloonEval

    let s:mapped[ string( bufnr() ) ] = { 'modifiable': &modifiable }

    setlocal nomodifiable

endfunction

function! s:OnDebugEnd() abort

    let original_buf = bufnr()
    let hidden = &hidden

    try
        set hidden
        for bufnr in keys( s:mapped )
            try
                execute 'noautocmd buffer' bufnr

                silent! nunmap <buffer> <leader>dc
                silent! nunmap <buffer> <leader>dv
                silent! nunmap <buffer> <leader>dW
                silent! nunmap <buffer> <leader>ds
                silent! nunmap <buffer> <leader>do

                silent! nunmap <buffer> <LocalLeader>de
                silent! nunmap <buffer> <LocalLeader>dE

                silent! nunmap <buffer> <LocalLeader>dw

                silent! nunmap <buffer> <LocalLeader>dc
                silent! nunmap <buffer> <LocalLeader>dh

                silent! nunmap <buffer> <LocalLeader>do
                silent! nunmap <buffer> <LocalLeader>dn
                silent! nunmap <buffer> <LocalLeader>df
                silent! nunmap <buffer> <LocalLeader>d_

                silent! nunmap <buffer> <LocalLeader>dc
                silent! nunmap <buffer> <LocalLeader>di

                silent! xunmap <buffer> <LocalLeader>di

                let &l:modifiable = s:mapped[ bufnr ][ 'modifiable' ]
            endtry
        endfor
    finally
        execute 'noautocmd buffer' original_buf
        let &hidden = hidden
    endtry

    let s:mapped = {}
endfunction

augroup TestCustomMappings
    au!
    autocmd User VimspectorJumpedToFrame call s:OnJumpToFrame()
    autocmd User VimspectorDebugEnded call s:OnDebugEnd()
augroup END

" setup boilerplate to make this file usable with vim -Nu <tihs file> {{{
function! s:CustomiseUI()
    let g:vimspector_sidebar_width = 60
    let wins = g:vimspector_session_windows

    " Close the Variables window
    if has( 'nvim' )
        " No win_execute in neovim
        call win_gotoid( wins.output )
        quit
    else
        call win_execute( wins.output, 'q' )
    endif
endfunction

augroup TestUICustomistaion
    autocmd!
    autocmd User VimspectorUICreated call s:CustomiseUI()
augroup END

" Custom mappings for special buffers {{{

let g:vimspector_mappings = {
            \   'variables': {
            \    'set_value': [ '<Tab>', '<C-CR>', 'C' ],
            \   }
            \ }
