local yaml_settings = {
    yaml = {
        schemaStore = {
            enable = true
        },
        schemas = {
            kubernetes = {
                "*deployment*.yaml",
                "*service*.yaml",
                "*account*.yaml",
                "*config*.yaml",
                "*pod*.yaml",
                "*ingress*.yaml",
                "*egress*.yaml",
                "*gateway*.yaml",
                "*policy.yml",
                "*deployment*.yml",
                "*service*.yml",
                "*account*.yml",
                "*config*.yml",
                "*pod*.yml",
                "*ingress*.yml",
                "*policy.yml",
                "*gateway*.yml",
                "*egress*.yml",
            }
        }
    }
}


local M = {}

M.get_settings = function()
    return yaml_settings
end

return M

