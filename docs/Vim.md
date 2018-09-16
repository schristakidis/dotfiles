### Surround

#####Change Surround

    cs{from}{to}

 for any tag use t for from
 
    <q>Hello World</q>
    cst'
    'Hello World'

##### Delete Surround

    ds{surround}

##### Add Surround

    ys{motion}[surround}

or on Visual
    
    S{surround}

for line processing use ss instead of s for every operation

[Github](https://github.com/tpope/vim-surround)


### Tabularize

On Visual Selection
```
:Tabularize /<seperatror pattern like (':', '=', '|')
```

##### Potential mappings
```
let mapleader=','
if exists(":Tabularize")
    nmap <Leader>a= :Tabularize /=<CR>
    vmap <Leader>a= :Tabularize /=<CR>
    nmap <Leader>a: :Tabularize /:\zs<CR>
    vmap <Leader>a: :Tabularize /:\zs<CR>
endif
```

#####Potential Function to automatically tabularize on | (for table creation)

```viml
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

