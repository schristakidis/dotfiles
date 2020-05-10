nnoremap gm m

nnoremap m d
xnoremap m d

nnoremap mm dd
nnoremap M D

nmap p <plug>(YoinkPaste_p)
nmap P <plug>(YoinkPaste_P)

xmap s <plug>(SubversiveSubstitute)
xmap p <plug>(SubversiveSubstitute)
xmap P <plug>(SubversiveSubstitute)

nmap s <plug>(SubversiveSubstitute)
nmap ss <plug>(SubversiveSubstituteLine)
nmap S <plug>(SubversiveSubstituteToEndOfLine)

nmap <leader>cp <plug>(YoinkPostPasteSwapBack)
nmap <leader>cn <plug>(YoinkPostPasteSwapForward)

nmap <leader>cf <plug>(YoinkPostPasteToggleFormat)

let g:yoinkIncludeDeleteOperations = 1
let g:yoinkSavePersistently = 1
let g:yoinkSwapClampAtEnds = 0  " circle through the yank history
let g:yoinkAutoFormatPaste = 1

nmap <leader>s <plug>(SubversiveSubstituteRange)
xmap <leader>s <plug>(SubversiveSubstituteRange)

nmap <leader>ss <plug>(SubversiveSubstituteWordRange)

