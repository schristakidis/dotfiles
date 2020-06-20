if empty(glob('~/.dotfiles/vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source ~/.vimrc
endif

set nocompatible

function! Cond(cond, ...)
    let opts = get(a:000, 0, {})
    return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

call plug#begin('~/.dotfiles/vim/vundle') 

" General
Plug 'Valloric/ListToggle'
Plug 'fholgado/minibufexpl.vim'
Plug 'scrooloose/nerdtree'
Plug 'szw/vim-maximizer'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'wellle/targets.vim'
Plug 'godlygeek/tabular'
Plug 'bronson/vim-visual-star-search'
Plug 'unblevable/quick-scope'
Plug 'Shougo/denite.nvim', has('nvim') ? {'do': 'UpdateRemotePlugins'} : { 'on': [] } 
Plug 'lambdalisue/suda.vim'

" tmux
Plug 'benmills/vimux'
Plug 'christoomey/vim-tmux-navigator'

" Docs
Plug 'plasticboy/vim-markdown'
Plug 'vimwiki/vimwiki', { 'branch': 'dev' }
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
Plug 'dhruvasagar/vim-table-mode'
Plug 'mzlogin/vim-markdown-toc'

" Git
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'airblade/vim-gitgutter'

" Easyclip/Yanking
Plug 'svermeulen/vim-cutlass'
Plug 'svermeulen/vim-yoink'
Plug 'svermeulen/vim-subversive'
Plug 'machakann/vim-highlightedyank', Cond(has('nvim'))

" Programming
Plug 'dense-analysis/ale'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tomtom/tcomment_vim'
Plug 'Chiel92/vim-autoformat'
Plug 'janko-m/vim-test'
Plug 'Shougo/echodoc.vim'
Plug 'liuchengxu/vista.vim'
Plug 'sheerun/vim-polyglot'

" Python
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'jeetsukumaran/vim-pythonsense'
" Plug 'vim-python/python-syntax'
Plug 'michaeljsmith/vim-indent-object'

" Theming
Plug 'morhetz/gruvbox'
Plug 'mhartington/oceanic-next'
Plug 'joshdick/onedark.vim'
Plug 'lifepillar/vim-solarized8'
Plug 'ryanoasis/vim-devicons'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'


call plug#end()
