require("config.devicons")
require("config.undotree")
require("config.treesiter")
require("neodev").setup({
        library = { plugins = { "neotest" }, types = true },
    })
require("config.neotest")
require("config.lsp")
require("config.compe")
require("config.gitsigns")
require("config.feline")
require('config.trouble')
require("config.telescope")
require("config.bufferline")
require('Comment').setup()
require('treesitter-context').setup()
require("nvim-gps").setup()
require('bqf').setup({
        preview = {
            auto_preview = false
        }
    })
require('neorg').setup {
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
                    default = "~/notes",
                    work = "~/notes/work",
                    home = "~/notes/home",
                },
                default_workspace = "home"
            },
        },
    },
}
