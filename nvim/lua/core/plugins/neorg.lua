vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    pattern = { "*.norg" },
    command = "set conceallevel=3"
})

M = {
    'nvim-neorg/neorg',
    dependencies = {
        "nvim-lua/plenary.nvim"
    },
    ft = "norg",
    lazy = false,
    -- cmd = "Neorg",
    build = ":Neorg sync-parsers",
    opts = {
        load = {
            ["core.defaults"] = {}, -- Loads default behaviour
            ["core.concealer"] = {}, -- Adds pretty icons to your documents
            ["core.export"] = {
                config = {
                    export_dir = "~/notes/markdown"
                }
            },
            ["core.export.markdown"] = {},
            ["core.completion"] = {
                config = {
                    engine = "nvim-cmp"
                },
            },
            ["core.dirman"] = { -- Manages Neorg workspaces
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
