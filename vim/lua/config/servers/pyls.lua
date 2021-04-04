local pyls_settings = {
    pyls = {
        configurationSources = { "pycodestyle" },
        plugins = {
            jedi_completion = {
                enabled = false
            },
            jedi_definition = {
                enabled = false
            },
            jedi_hover = {
                enabled = false
            },
            jedi_references = {
                enabled = false
            },
            jedi_signature_help = {
                enabled = false
            },
            jedi_symbols = {
                enabled = false
            },
            mccabe = {
                enabled = false
            },
            pycodestyle = {
                enabled = true
            },
            pyflakes = {
                enabled = false
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

local M = {}

M.get_settings = function()
    return pyls_settings
end

return M
