local servers = {
    -- "docker_compose_language_service",
    "bashls",
    "pyright",
    "pylsp",
    "dockerls",
    "jsonls",
    "lua_ls",
    "terraformls",
    "yamlls",
    "vimls",
    -- "phpactor",
    "gopls"
}

require("mason").setup()
require("mason-lspconfig").setup {
    ensure_installed = servers
}


local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[e', function() vim.diagnostic.goto_prev { severity_limit = "Warning" } end, opts)
vim.keymap.set('n', ']e', function() vim.diagnostic.goto_next { severity_limit = "Warning" } end, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)


local on_attach = function(_, bufnr)
    require('lsp_signature').on_attach()

    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local bufopts = { noremap = true, silent = true, buffer = bufnr }

    vim.keymap.set('n', '<leader>g', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', '<leader>d', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', '<leader>i', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<gk>', vim.lsp.buf.signature_help, bufopts)

    vim.keymap.set('n', 'gR', vim.lsp.buf.references, bufopts)

    vim.keymap.set('n', '<leader>ss', function() require('telescope.builtin').lsp_document_symbols() end, bufopts)
    vim.keymap.set('n', '=', function() vim.lsp.buf.format { timeout_ms = 2000, async = true } end, bufopts)
    vim.keymap.set('v', '=', function() vim.lsp.buf.format { timeout_ms = 2000, async = true } end, bufopts)

    -- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
    --     vim.lsp.handlers.hover, {
    --         -- Use a sharp border with `FloatBorder` highlights
    --         border = "single"
    --     }
    -- )


    -- local function preview_location_callback(_, result)
    --   if result == nil or vim.tbl_isempty(result) then
    --     return nil
    --   end
    --   vim.lsp.util.preview_location(result[1])
    -- end

    -- function PeekDefinition()
    --   local params = vim.lsp.util.make_position_params()
    --   return vim.lsp.buf_request(0, 'textDocument/definition', params, preview_location_callback)
    -- end
    --
    -- vim.keymap.set('n', '<space>p', PeekDefinition, opts)

    -- UI
    vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = false,
        signs = true,
        underline = true,
        update_in_insert = false,
    })

    local signs = { Error = " ", Warn = "", Hint = " ", Info = " " }

    for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end

    -- vim.api.nvim_create_autocmd("CursorHold", {
    --     buffer = bufnr,
    --     callback = function()
    --         local auto_opts = {
    --             focusable = false,
    --             close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
    --             border = 'rounded',
    --             source = 'always',
    --             prefix = ' ',
    --             scope = 'cursor',
    --         }
    --         vim.diagnostic.open_float(nil, auto_opts)
    --     end
    -- })
end

local function get_capabilities()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
    return capabilities
end

local function make_config()
    return {
        -- enable snippet support
        capabilities = get_capabilities(),
        -- map buffer local keybindings when the language server attaches
        on_attach = on_attach,
        flags = {
            debounce_text_changes = 150,
        }
    }
end


-- local function get_root_basename()
--     local lspconfig = require('lspconfig')
--
--     local root_pattern = lspconfig.util.root_pattern('.git')
--     local bufname = vim.api.nvim_buf_get_name(0)
--     -- Turned into a filename
--     local filename = lspconfig.util.path.is_absolute(bufname) and bufname or
--         lspconfig.util.path.join(vim.loop.cwd(), bufname)
--     -- Then the directory of the project
--     local project_dirname = root_pattern(filename) or lspconfig.util.path.dirname(filename)
--     -- And finally perform what is essentially a `basename` on this directory
--     return vim.fn.fnamemodify(lspconfig.util.find_git_ancestor(project_dirname), ':t')
-- end

local function is_python2()
    local version = vim.api.nvim_exec([[echo system('python -V')]], true)
    if string.find(version, "Python 2.") then
        return true
    else
        return false
    end
end

for _, lsp in pairs(servers) do
    local default_opts = make_config()
    local enable = true
    if lsp == "lua_ls" then
        default_opts.settings = require('core.plugins.lsp.servers.lua').get_settings()
    elseif lsp == "pylsp" then
        if is_python2() then
            default_opts.settings = require('core.plugins.lsp.servers.python').get_pylsp_settings_2()
        else
            default_opts.settings = require('core.plugins.lsp.servers.python').get_pylsp_settings()
        end
    elseif lsp == "pyright" then
        default_opts.settings = require('core.plugins.lsp.servers.python').get_pyright_settings()
        if is_python2() then
            enable = false
        end
    elseif lsp == "jsonls" then
        default_opts.settings = {
            json = {
                schemas = require('schemastore').json.schemas(),
                validate = { enable = true }
            },
        }
    elseif lsp == "yamlls" then
        local cfg = require("yaml-companion").setup()
        local cfg2 = require("yaml-companion").setup()
        cfg.on_attach = function(_, bufnr)
            cfg2.on_attach(_, bufnr)
            on_attach(_, bufnr)
        end
        cfg.filetypes = { "yaml", "yaml.docker-compose", "helm" }
        cfg.capabilities = get_capabilities()
        require("lspconfig")["yamlls"].setup(cfg)
        enable = false
    elseif lsp == "gopls" then
        default_opts.settings = require('core.plugins.lsp.servers.gopls').get_settings()
    end

    if enable then
        require('lspconfig')[lsp].setup(default_opts)
    end
end


local null_ls = require("null-ls")

null_ls.setup({
    sources = {
        -- null_ls.builtins.diagnostics.flake8.with({
        --     diagnostic_config = {
        --         virtual_text = false,
        --     }
        -- })
        null_ls.builtins.formatting.yapf.with({
            extra_args = { "--style", "facebook" }
        }),
        null_ls.builtins.code_actions.gitsigns,
        null_ls.builtins.formatting.isort,
        null_ls.builtins.formatting.jq,
        null_ls.builtins.formatting.gofmt,
        null_ls.builtins.formatting.goimports,
    }
})

require("mason-null-ls").setup({
    ensure_installed = { "yapf", "jq", "xmllint", "isort" },
    automatic_installation = true,
    automatic_setup = false
})
