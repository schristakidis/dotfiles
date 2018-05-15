set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
set guicursor=
let $TERM = "vte-256color"
set autoread
au FocusGained * :checktime
let g:python_host_prog = $PYENV_ROOT . "/versions/neovim2/bin/python"
let g:python3_host_prog = $PYENV_ROOT . "/versions/neovim3/bin/python"
