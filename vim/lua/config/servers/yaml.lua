local yaml_settings = {
    yaml = {
        schemas = {
            ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = {"/.gitlab-ci*.yaml", "/.gitlab-ci*.yml"},
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

