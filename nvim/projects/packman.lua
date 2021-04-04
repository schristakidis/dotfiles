local pyls_settings = {
    pyls = {
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

require'lspconfig'.pyls.setup{
    settings = pyls_settings,
    cmd = { "pyls", '--log-file', '/tmp/pyls-log.txt' }
}

require'lspconfig'.python.setup{
    autostart = false,
    cmd = { 'ls' },
}
