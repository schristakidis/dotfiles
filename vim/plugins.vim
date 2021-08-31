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
Plug 'junkblocker/git-time-lapse'

" Easyclip/Yanking
Plug 'svermeulen/vim-cutlass'
Plug 'svermeulen/vim-yoink'
Plug 'svermeulen/vim-subversive'
Plug 'machakann/vim-highlightedyank', Cond(has('nvim'))

" Programming
Plug 'tomtom/tcomment_vim'
Plug 'Chiel92/vim-autoformat'
Plug 'janko-m/vim-test'
Plug 'sheerun/vim-polyglot'
Plug 'liuchengxu/vista.vim'

" Python
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'jeetsukumaran/vim-pythonsense'
Plug 'michaeljsmith/vim-indent-object'

" Theming
Plug 'tjdevries/colorbuddy.vim'
Plug 'joshdick/onedark.vim'
Plug 'Th3Whit3Wolf/one-nvim', {'branch': 'main'}
Plug 'mhartington/oceanic-next'
Plug 'marko-cerovac/material.nvim'

" NeoVim 0.5
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'hrsh7th/nvim-compe'
Plug 'kabouzeid/nvim-lspinstall', { 'branch': 'main' }
Plug 'neovim/nvim-lspconfig'
Plug 'lewis6991/gitsigns.nvim', { 'branch': 'main' }
Plug 'glepnir/galaxyline.nvim' , {'branch': 'main'}
Plug 'onsails/lspkind-nvim' 
Plug 'Raimondi/delimitMate'
Plug 'ray-x/lsp_signature.nvim'
Plug 'npxbr/glow.nvim', {'branch': 'main', 'do': ':GlowInstall'}
Plug 'lewis6991/spellsitter.nvim'
Plug 'gennaro-tedesco/nvim-jqx'
Plug 'windwp/nvim-projectconfig'
Plug 'folke/trouble.nvim'

Plug 'puremourning/vimspector'

Plug 'nvim-telescope/telescope-dap.nvim'
Plug 'mfussenegger/nvim-dap'
Plug 'mfussenegger/nvim-dap-python'
Plug 'rcarriga/vim-ultest', { 'do': ':UpdateRemotePlugins' }
Plug 'rcarriga/nvim-dap-ui'

Plug 'dbeniamine/cheat.sh-vim'

call plug#end()
