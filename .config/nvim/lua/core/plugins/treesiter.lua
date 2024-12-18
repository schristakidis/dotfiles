local M = {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "BufReadPost",
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
        "RRethy/nvim-treesitter-endwise",
        "mfussenegger/nvim-ts-hint-textobject",
        "windwp/nvim-ts-autotag",
        "nvim-treesitter/playground",
    },
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                "c", "lua", "vim", "vimdoc", "query", "python", "go", "terraform", "yaml",
                "dockerfile", "json", "markdown", "norg", "markdown_inline"
            },
            ignore_install = { "phpdoc" }, -- List of parsers to ignore installing
            sync_install = false,
            auto_install = true,
            highlight = {
                enable = true,             -- false will disable the whole extension
                disable = { "c", "rust" }, -- list of language that will be disabled
                custom_captures = {
                    ["error"] = "Normal"
                },
                additional_vim_regex_highlighting = false,
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "gnn",
                    node_incremental = "grn",
                    scope_incremental = "grc",
                    node_decremental = "grm",
                },
            },
            endwise = {
                enable = true,
            },
            indent = {
                enable = true,
                disable = { "python", "yaml" } -- python not working, yaml not sure
            },
            autopairs = { enable = true },
            textobjects = {
                select = {
                    enable = true,
                    -- Automatically jump forward to textobj, similar to targets.vim
                    lookahead = true,
                    keymaps = {
                        -- You can use the capture groups defined in textobjects.scm
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                        ["ac"] = "@class.outer",
                        ["ic"] = "@class.inner",
                        ["al"] = "@loop.outer",
                        ["il"] = "@loop.inner",
                        ["ib"] = "@block.inner",
                        ["ab"] = "@block.outer",
                        ["ir"] = "@parameter.inner",
                        ["ar"] = "@parameter.outer",
                    },
                },
            },
            playground = {
                enable = true,
                disable = {},
                updatetime = 25,         -- Debounced time for highlighting nodes in the playground from source code
                persist_queries = false, -- Whether the query persists across vim sessions
                keybindings = {
                    toggle_query_editor = 'o',
                    toggle_hl_groups = 'i',
                    toggle_injected_languages = 't',
                    toggle_anonymous_nodes = 'a',
                    toggle_language_display = 'I',
                    focus_language = 'f',
                    unfocus_language = 'F',
                    update = 'R',
                    goto_node = '<cr>',
                    show_help = '?',
                },
            }
        })

        require("nvim-ts-autotag").setup()
    end,
}

return M
