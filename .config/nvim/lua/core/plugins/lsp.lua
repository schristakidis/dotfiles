local M = {
  "neovim/nvim-lspconfig",
  -- "onsails/lspkind-nvim",
  dependencies = {
    "onsails/lspkind-nvim",
    'ray-x/lsp_signature.nvim',
    "nvimtools/none-ls.nvim",
    "nvim-lua/plenary.nvim",
    'b0o/SchemaStore.nvim',
    'someone-stole-my-name/yaml-companion.nvim',
    'cenk1cenk2/schema-companion.nvim',
    { 'williamboman/mason.nvim',           config = true },
    { 'jay-babu/mason-null-ls.nvim',       config = true },
    { "folke/lazydev.nvim",                 config = true },
    { 'stevearc/conform.nvim', opts = {} }
  },
  config = function()
    require("core.plugins.lsp.lsp")
  end,
}

return M
