" hi Comment cterm=italic
"
" let g:onedark_hide_endofbuffer=1
" let g:onedark_terminal_italics=1
" let g:onedark_termcolors=256
" colo onedark
" " lua require('colorbuddy').colorscheme('one-nvim')

if (has("termguicolors"))
    set termguicolors
    hi LineNr ctermbg=NONE guibg=NONE
endif

colorscheme onedark
" colorscheme tokyonight
