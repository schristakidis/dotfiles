set background=dark

augroup my_colours
      autocmd!
        autocmd ColorScheme solarized8 hi SpellBad cterm=underline
augroup END

" colo solarized8
" hi Quote ctermbg=109 guifg=#83a598
" colo OceanicNext


hi Comment cterm=italic

let g:onedark_hide_endofbuffer=1
let g:onedark_terminal_italics=1
let g:onedark_termcolors=256
" colo onedark
lua require('colorbuddy').colorscheme('one-nvim')
"
" let g:material_style = 'default'
" lua require('colorbuddy').colorscheme('material')

if (has("termguicolors"))
    set termguicolors
    hi LineNr ctermbg=NONE guibg=NONE
endif
