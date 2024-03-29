let mapleader=','
let maplocalleader = "\<Space>"

syntax on
filetype plugin indent on
set noshowmode
syntax enable                           " Enables syntax highlighing
set iskeyword+=-                      	" treat dash separated words as a word text object"
set hidden                              " Required to keep multiple buffers open multiple buffers
set encoding=utf-8                      " The encoding displayed 
set fileencoding=utf-8                  " The encoding written to file
set t_Co=256                            " Support 256 colors
set smartindent                         " Makes indenting smart
set autoindent                          " Good auto indent
set laststatus=2                        " Always display the status line
set cursorline                          " Enable highlighting of the current line
set background=dark                     " tell vim what the background color looks like
set nobackup                            " This is recommended by coc
set nowritebackup                       " This is recommended by coc
set shortmess+=c                        " Don't pass messages to |ins-completion-menu|.
set signcolumn=yes
set updatetime=250                      " Faster completion
set hlsearch
set incsearch
set ignorecase
set smartcase
set title
set autochdir                           " automatically change window's cwd to file's dir
set backspace=indent,eol,start
set clipboard=unnamed
set showmatch                           " Show matching brackets when text indicator is over them
set mat=2                               " How many tenths of a second to blink when matching brackets
set inccommand=nosplit

" set pumheight=10                        " Makes popup menu smaller
" set cmdheight=2                         " More space for displaying messages

set foldmethod=indent
set foldignore=
set foldenable
set foldlevel=99

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set smarttab                            " Makes tabbing smarter will realize you have 2 vs 4
set nowrap

set number

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END


let g:clipboard = {
    \ 'name': 'xsel_override',
    \ 'copy': {
    \     '+': 'xsel --input --clipboard',
    \     '*': 'xsel --input --primary',
    \ },
    \ 'paste': {
    \     '+': 'xsel --output --clipboard',
    \     '*': 'xsel --output --primary',
    \ },
    \ 'cache_enabled': 1,
\ }

"move swap files to vim tmp directories
set backupdir=~/.vim/tmp/backup_files//
set directory=~/.vim/tmp/swap_files//
set undodir=~/.vim/tmp/undo_files//

let g:highlightedyank_highlight_duration = 100

augroup my_filetypes
    autocmd!
    autocmd Filetype python setlocal ts=4 ts=4 sw=4 sts=4 expandtab completeopt-=preview colorcolumn=80
    autocmd Filetype php setlocal ts=2 ts=2 sw=2 sts=2 expandtab
    autocmd Filetype javascript setlocal ts=2 ts=2 sw=2 sts=2 expandtab

    " django html highlighting
    " au BufNewFile,BufRead *.html set filetype=htmldjango
    autocmd BufNewFile,BufRead *.jinja2 set filetype=htmljinja
    autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags noci
    autocmd FileType html,jinja2 set omnifunc=htmlcomplete#CompleteTags noci
    autocmd Filetype html,htmljinja setlocal ts=2 ts=2 sw=2 sts=2 expandtab

    autocmd BufNewFile,BufReadPost *.md set filetype=markdown
    "
    " Enable spell check for markdown files
    au FileType markdown setlocal spell

    au FileType go set noexpandtab
    au FileType go set shiftwidth=4
    au FileType go set softtabstop=4
    au FileType go set tabstop=4

    au! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml foldmethod=indent
    autocmd FileType yaml,yml setlocal ts=2 sts=2 sw=2 expandtab

    au! BufNewFile,BufReadPost *.tf set filetype=terraform foldmethod=indent
    autocmd FileType yaml,yml setlocal ts=2 sts=2 sw=2 expandtab
augroup END

" open quickfix window after grep commands
augroup my_quickfix_window
    autocmd!
    autocmd QuickFixCmdPost *grep* cwindow
augroup END

"----------------------------------------------------------
"MAPPINGS
"---------------------------------------------------------
"

" Disable annoying Ex mode
nnoremap Q <Nop>

" Better way to move between windows
noremap <C-j> <C-W>j
noremap <C-k> <C-W>k
noremap <C-h> <C-W>h
noremap <C-l> <C-W>l

nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

"insert a new line in normal mode
nnoremap <S-Enter> O<Esc>

nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" Copy to primary registry'
" vnoremap <C-c> "*y
" Select all text
nnoremap <C-a> ggVG

if has('nvim')
    noremap <A-v> "+p
    vnoremap <A-p> "+y
endif


" close scratch buferr
noremap <C-q> <C-W>z

" Close location window also with :bd
" nnoremap <silent> <C-d> :lclose<CR>:bdelete<CR>
cabbrev <silent> bd <C-r>=(getcmdtype()==#':' && getcmdpos()==1 ? 'lclose\|bdelete' : 'bd')<CR>

noremap U <C-R>

map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

let g:delimitMate_expand_cr=1
