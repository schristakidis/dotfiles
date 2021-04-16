require("config.telescope")
require("config.devicons")
require("config.treesiter")
require("config.lsp")
require("config.compe")
require("config.kind")
require("config.saga")
require("config.gitsigns")
require("config.galaxy")
-- require("config.dap")
require('lsp_signature').on_attach()
require('spellsitter').setup()
require('nvim-projectconfig').load_project_config()
