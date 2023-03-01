M = {
  'nvim-neorg/neorg',
  dependencies = {
    "nvim-lua/plenary.nvim"
  },
  ft = "norg",
  cmd = "Neorg",
  build = ":Neorg sync-parsers",
  opts = {
    load = {
      ["core.defaults"] = {}, -- Loads default behaviour
      ["core.norg.concealer"] = {}, -- Adds pretty icons to your documents
      ["core.export"] = {
        config = {
          export_dir = "~/notes/markdown"
        }
      },
      ["core.export.markdown"] = {},
      ["core.norg.completion"] = {
        config = {
          engine = "nvim-cmp"
        },
      },
      ["core.norg.dirman"] = { -- Manages Neorg workspaces
        config = {
          workspaces = {
            home = "~/notes/home",
            work = "~/notes/work",
          },
          default_workspace = "home"
        },
      },
    },
  }
}

return M
