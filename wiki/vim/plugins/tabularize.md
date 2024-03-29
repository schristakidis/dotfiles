### Tabularize

On Visual Selection

```vim
:Tabularize /<seperatror pattern like (':', '=', '|')
```

##### Potential mappings

```vim
let mapleader=','
if exists(":Tabularize")
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a: :Tabularize /:\zs<CR>
vmap <Leader>a: :Tabularize /:\zs<CR>
endif
```

##### Potential Function to automatically tabularize on | (for table creation)

```vim
inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

function! s:align()
let p = '^\s*|\s.*\s|\s*$'
if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
Tabularize/|/l1
normal! 0
call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
endif
endfunction
```
