set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
set guicursor=
set autoread
au FocusGained * :checktime
let g:python_host_prog = $HOME . "/.virtualenvs/neovim2/bin/python"
let g:python3_host_prog = $HOME . "/.virtualenvs/neovim39/bin/python"
