vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    pattern = { "*.norg" },
    callback = function()
        vim.opt.ft = 'norg'
        vim.opt_local.conceallevel = 3
    end,
})


M = {
    'nvim-neorg/neorg',
    dependencies = {
        "luarocks.nvim"
    },
    ft = "norg",
    lazy = false,
    -- cmd = "Neorg",
    versions = "*",
    -- config = true,
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
