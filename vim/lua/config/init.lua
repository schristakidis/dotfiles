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
