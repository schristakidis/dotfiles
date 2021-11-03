local pylsp_settings = {
    pylsp = {
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


local pylsp_settings2 = {
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
                enabled = true
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
local pyright_settings = {
    python = {
        analysis = {
            typeCheckingMode = "basic",
            diagnosticSeverityOverrides = {
                reportGeneralTypeIssues = "none"
            }
        }
    }
}

local M = {}

M.get_pylsp_settings = function()
    return pylsp_settings
end

M.get_pylsp_settings_2 = function()
    return pylsp_settings2
end

M.get_pyright_settings = function()
    return pyright_settings
end

return M
