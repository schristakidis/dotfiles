local cfg = require("yaml-companion").setup({
  on_new_config = function(new_config)
    new_config.settings.yaml.schemas = vim.tbl_deep_extend(
      "force",
      new_config.settings.yaml.schemas or {},
      require("schemastore").yaml.schemas()
    )
  end,
  -- lspconfig = {
  --   on_attach = on_attach,
  --   capabilities = get_capabilities()
  -- },
  settings = {
    redhat = { telemetry = { enabled = false } },
    yaml = {
      keyOrdering = false,
      format = {
        enable = true,
      },
      validate = true,
      schemaStore = {
        -- Must disable built-in schemaStore support to use
        -- schemas from SchemaStore.nvim plugin
        enable = false,
        -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
        url = "",
      },
      schemas = require('schemastore').yaml.schemas(),
    },
  },
})
--
-- cfg.cmd = { 'yaml-language-server', '--stdio' }
-- cfg.filetypes = { 'yaml', 'yaml.docker-compose', 'yaml.gitlab', 'yaml.helm-values' }
-- cfg.root_markers = { '.git' }
--
print(vim.inspect(cfg))
-- return cfg

-- return {
--   cmd = { 'yaml-language-server', '--stdio' },
--   filetypes = { 'yaml', 'yaml.docker-compose', 'yaml.gitlab', 'yaml.helm-values' },
--   root_markers = { '.git' },
--   settings = {
--     redhat = { telemetry = { enabled = false } },
--     yaml = {
--       keyOrdering = false,
--       format = {
--         enable = true,
--       },
--       validate = true,
--       schemaStore = {
--         -- Must disable built-in schemaStore support to use
--         -- schemas from SchemaStore.nvim plugin
--         enable = false,
--         -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
--         url = "",
--       },
--       schemas = require('schemastore').yaml.schemas(),
--     },
--     yaml2 = {
--       validate = true,
--       format = { enable = true },
--       hover = true,
--       schemaStore = {
--         enable = true,
--         url = "https://www.schemastore.org/api/json/catalog.json",
--       },
--       schemaDownload = { enable = true },
--       schemas = {},
--       trace = { server = "debug" },
--     },
--   },
-- }
--

-- local cfg = require("yaml-companion").setup {
--   -- detect k8s schemas based on file content
--   builtin_matchers = {
--     kubernetes = { enabled = true }
--   },
--
--   -- schemas available in Telescope picker
--   schemas = {
--     -- not loaded automatically, manually select with
--     -- :Telescope yaml_schema
--     {
--       name = "Argo CD Application",
--       uri = "https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/argoproj.io/application_v1alpha1.json"
--     },
--     {
--       name = "SealedSecret",
--       uri = "https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/bitnami.com/sealedsecret_v1alpha1.json"
--     },
--     -- schemas below are automatically loaded, but added
--     -- them here so that they show up in the statusline
--     {
--       name = "Kustomization",
--       uri = "https://json.schemastore.org/kustomization.json"
--     },
--     {
--       name = "GitHub Workflow",
--       uri = "https://json.schemastore.org/github-workflow.json"
--     },
--   },
--
--   lspconfig = {
--     settings = {
--       yaml = {
--         validate = true,
--         schemaStore = {
--           enable = false,
--           url = ""
--         },
--
--         -- schemas from store, matched by filename
--         -- loaded automatically schemas = require('schemastore').yaml.schemas {
--           select = {
--             'kustomization.yaml',
--             'GitHub Workflow',
--           }
--         }
--       }
--     }
--   }
-- }

-- require("lspconfig")["yamlls"].setup(cfg)
-- print(vim.inspect(cfg))
--ClientConfig return cfg---@type vim.lsp.Config
return  {
  cmd = { "yaml-language-server", "--stdio" },
  filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab" },
  root_markers = { ".git" },
  capabilities = {
    textDocument = {
      foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      },
    },
  },
  settings = {
    -- https://github.com/redhat-developer/vscode-redhat-telemetry#how-to-disable-telemetry-reporting
    redhat = { telemetry = { enabled = false } },
    yaml = {
      keyOrdering = false,
      format = {
        enable = true,
      },
      validate = true,
      schemaStore = {
        enabled = false,
        url = "",
      }
    },
  },
  on_attach = cfg.on_attach,
  handlers = cfg.handlers,
  -- on_attach = function(client, buf)
  --   client.server_capabilities.documentFormattingProvider = true
  -- end,
  before_init = function(_, new_config)
    new_config.settings.yaml.schemas = vim.tbl_deep_extend(
      "force",
      new_config.settings.yaml.schemas or {},
      require("schemastore").yaml.schemas()
    )
  end,
}

-- return cfg
