return {
  -- general
  { 'Valloric/ListToggle' },
  { 'tpope/vim-unimpaired' },
  { 'godlygeek/tabular' },
  { 'kyazdani42/nvim-web-devicons',       config = true },
  { 'nvim-lua/popup.nvim' },
  { "kylechui/nvim-surround",             version = "*", config = true },
  { "lukas-reineke/indent-blankline.nvim" },
  { 'lambdalisue/suda.vim' },

  -- tmux
  'benmills/vimux',
  {
    'christoomey/vim-tmux-navigator',
    config = function()
      vim.g.tmux_navigator_disable_when_zoomed = 1
    end
  },
  {
    'declancm/maximize.nvim', config = true
  },

  -- git
  "tpope/vim-fugitive",

  -- programming
  { 'numToStr/Comment.nvim',    config = true },
  'sheerun/vim-polyglot',
  { "gennaro-tedesco/nvim-jqx", ft = { "json", "yaml" } },
  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
    version = "2.*",
    build = "make install_jsregexp",
    config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
    end
  },
  { 'simrat39/symbols-outline.nvim', config = true,  cmd = "SymbolsOutline" },
  { 'Vimjas/vim-python-pep8-indent' },

  -- markdown
  { 'plasticboy/vim-markdown',       ft = 'markdown' },
  { 'mzlogin/vim-markdown-toc',      ft = 'markdown' },
  'dhruvasagar/vim-table-mode',
  { 'iamcco/markdown-preview.nvim', build = "cd app && yarn install" },
  { "ellisonleao/glow.nvim",        config = true,                   cmd = "Glow" }
}
