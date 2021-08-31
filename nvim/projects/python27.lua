local pylsp_settings = {
    pylsp = {
        configurationSources = { "pycodestyle" },
        plugins = {
            jedi_completion = {
                enabled = true
            },
            jedi_definition = {
                enabled = true
            },
            jedi_hover = {
                enabled = true
            },
            jedi_references = {
                enabled = true
            },
            jedi_signature_help = {
                enabled = true
            },
            jedi_symbols = {
                enabled = true
            },
            mccabe = {
                enabled = false
            },
            pycodestyle = {
                enabled =true
            },
            pyflakes = {
                enabled = true
            },
            pylint = {
                enabled = false
            },
            rope_completion = {
                enabled = false
            },
            yapf = {
                enabled = false
            }
        }
    }
}

local function setup_pylsp()
    local config = require('config.lsp').make_config()
    config.settings = pylsp_settings
    config.cmd = { "pylsp" }

    require'lspconfig'.pylsp.setup(config)
end

local function setup_pyright()
    local config = require('config.lsp').make_config()
    config.autostart = false
    config.cmd = {'ls'}
    require'lspconfig'.python.setup(config)
end


setup_pylsp()
setup_pyright()
