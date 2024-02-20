local M = {
  "neovim/nvim-lspconfig",
  dependencies = {
    "onsails/lspkind-nvim",
    'ray-x/lsp_signature.nvim',
    "nvimtools/none-ls.nvim",
    "nvim-lua/plenary.nvim",
    'b0o/SchemaStore.nvim',
    'someone-stole-my-name/yaml-companion.nvim',
    { 'williamboman/mason.nvim',           config = true },
    { 'williamboman/mason-lspconfig.nvim', config = true },
    { 'jay-babu/mason-null-ls.nvim',       config = true },
    { "folke/neodev.nvim",                 config = true },
  },
  config = function()
    require("core.plugins.lsp.lsp")
  end,
}

return M
