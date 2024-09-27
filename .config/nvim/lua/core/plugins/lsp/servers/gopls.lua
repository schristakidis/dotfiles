local go_settings = {
    gopls = {
        completeUnimported = true,
        -- usePlaceholders = true,
        analyses = {
            unusedparams = true,
            shadow = true,
        },
        staticcheck = true,
    }
}

local M = {}

M.get_settings = function()
    return go_settings
end

return M
