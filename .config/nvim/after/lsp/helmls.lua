-- return {
--   cmd = { 'helm_ls', 'serve' },
--   filetypes = { 'helm', 'yaml.helm-values' },
--   root_markers = { 'Chart.yaml' },
--   capabilities = {
--     workspace = {
--       didChangeWatchedFiles = {
--         dynamicRegistration = true,
--       },
--     },
--   },
-- }

-- your LSP file: ./after/lsp/helm_ls.lua
return require("schema-companion").setup_client(
  require("schema-companion").adapters.helmls.setup({
    sources = {
      -- your sources for the language server
      require("schema-companion").sources.matchers.kubernetes.setup({ version = "master" }),
    },
  }),
  {
    cmd = { 'helm_ls', 'serve' },
    filetypes = { 'helm', 'yaml.helm-values' },
    root_markers = { 'Chart.yaml' },
    capabilities = {
      workspace = {
        didChangeWatchedFiles = {
          dynamicRegistration = true,
        },
      },
    },
  }
)
