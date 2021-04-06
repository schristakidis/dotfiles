nnoremap gm m

nnoremap m d
xnoremap m d

nnoremap mm dd
nnoremap M D

" nmap p <plug>(YoinkPaste_p)
" nmap P <plug>(YoinkPaste_P)
"
" nmap <leader>yp <plug>(YoinkPostPasteSwapBack)
" nmap <leader>yn <plug>(YoinkPostPasteSwapForward)

nmap <expr> p yoink#canSwap() ? '<plug>(YoinkPostPasteSwapBack)' : '<plug>(YoinkPaste_p)'
nmap <expr> P yoink#canSwap() ? '<plug>(YoinkPostPasteSwapForward)' : '<plug>(YoinkPaste_P)'

nmap <leader>yf <plug>(YoinkPostPasteToggleFormat)

let g:yoinkIncludeDeleteOperations = 1
let g:yoinkSavePersistently = 1
let g:yoinkSwapClampAtEnds = 0  " circle through the yank history
let g:yoinkAutoFormatPaste = 0

xmap s <plug>(SubversiveSubstitute)
xmap p <plug>(SubversiveSubstitute)
xmap P <plug>(SubversiveSubstitute)

nmap s <plug>(SubversiveSubstitute)
nmap ss <plug>(SubversiveSubstituteLine)
nmap S <plug>(SubversiveSubstituteToEndOfLine)

nmap <leader>s <plug>(SubversiveSubstituteRange)
xmap <leader>s <plug>(SubversiveSubstituteRange)

nmap <leader>ss <plug>(SubversiveSubstituteWordRange)
