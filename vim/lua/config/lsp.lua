local on_attach = function(client, bufnr)
    require('lsp_signature').on_attach()

    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = { noremap=true, silent=true }
    buf_set_keymap('n', '<leader>g', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', '<leader>d', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', '<leader>i', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<gk>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)

    -- buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    -- buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    -- buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    -- buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    -- buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)

    buf_set_keymap('n', 'gR', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    buf_set_keymap('n', '[e', '<cmd>lua vim.lsp.diagnostic.goto_prev({severity_limit = "Warning"})<CR>', opts)
    buf_set_keymap('n', ']e', '<cmd>lua vim.lsp.diagnostic.goto_next({severity_limit = "Warning"})<CR>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<leader>L', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

    buf_set_keymap('n', '<leader>ss', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)

    -- Set some keybinds conditional on server capabilities
    if client.resolved_capabilities.document_formatting then
        buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    elseif client.resolved_capabilities.document_range_formatting then
        buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
    end

    -- Set autocommands conditional on server_capabilities
    -- if client.resolved_capabilities.document_highlight then
        --   vim.api.nvim_exec([[
            --   augroup lsp_document_highlight
            --   autocmd! * <buffer>
            --   autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
            --   autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
            --   augroup END
            --   ]], false)
    -- end
    --
    -- UI
    vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
            virtual_text = false,
            signs = true,
            underline = true,
            update_in_insert = false,
        })

    local signs = { Error = " ", Warning = " ", Hint = " ", Information = " " }

    for type, icon in pairs(signs) do
        local hl = "LspDiagnosticsSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    -- function PrintDiagnostics(opts, bufnr, line_nr, client_id)
    --     opts = opts or {}
    --
    --     bufnr = bufnr or 0
    --     line_nr = line_nr or (vim.api.nvim_win_get_cursor(0)[1] - 1)
    --
    --     local line_diagnostics = vim.lsp.diagnostic.get_line_diagnostics(bufnr, line_nr, opts, client_id)
    --     if vim.tbl_isempty(line_diagnostics) then return end
    --
    --     local diagnostic_message = ""
    --     for i, diagnostic in ipairs(line_diagnostics) do
    --         diagnostic_message = diagnostic_message .. string.format("%d: %s", i, diagnostic.message or "")
    --         print(diagnostic_message)
    --         if i ~= #line_diagnostics then
    --             diagnostic_message = diagnostic_message .. "\n"
    --         end
    --     end
    --     vim.api.nvim_echo({{diagnostic_message, "Normal"}}, false, {})
    -- end
    --
    -- vim.cmd [[ autocmd CursorHold * lua PrintDiagnostics() ]]

end

-- config that activates keymaps and enables snippet support
local function make_config()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    return {
        -- enable snippet support
        capabilities = capabilities,
        -- map buffer local keybindings when the language server attaches
        on_attach = on_attach,
    }
end

local lsp_installer = require("nvim-lsp-installer")
local servers = {
    "bashls",
    "pyright",
    "pylsp",
    "dockerls",
    "jsonls",
    "sumneko_lua",
    "terraformls",
    "yamlls",
}

for _, name in pairs(servers) do
    local ok, server = lsp_installer.get_server(name)
    -- Check that the server is supported in nvim-lsp-installer
    if ok then
        if not server:is_installed() then
            print("Installing " .. name)
            server:install()
        end
    end
end

local function get_root_basename()
    local lspconfig = require('lspconfig')

    local root_pattern = lspconfig.util.root_pattern('.git')
    local bufname = vim.api.nvim_buf_get_name(0)
    -- Turned into a filename
    local filename = lspconfig.util.path.is_absolute(bufname) and bufname or lspconfig.util.path.join(vim.loop.cwd(), bufname)
    -- Then the directory of the project
    local project_dirname = root_pattern(filename) or lspconfig.util.path.dirname(filename)
    -- And finally perform what is essentially a `basename` on this directory
    return vim.fn.fnamemodify(lspconfig.util.find_git_ancestor(project_dirname), ':t')
end


local function is_python2()
    local version = vim.api.nvim_exec([[echo system('python -V')]], true)
    if string.find(version, "Python 2.") then
      return true
    else
      return false
    end
end

lsp_installer.on_server_ready(function(server)
    -- Specify the default options which we'll use for pyright and solargraph
    -- Note: These are automatically setup from nvim-lspconfig. See https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md
    local default_opts = make_config()

    local server_opts = {
        ["sumneko_lua"] =  function ()
            default_opts = make_config()
            default_opts.settings = require('config.servers.lua').get_settings()
            return default_opts
        end,
        ["pylsp"] = function ()
            default_opts = make_config()
            if is_python2() then
                default_opts.settings = require('config.servers.python').get_pylsp_settings_2()
            else
                default_opts.settings = require('config.servers.python').get_pylsp_settings()
            end
            return default_opts
        end,
        ["pyright"] = function ()
            default_opts = make_config()
            default_opts.settings = require('config.servers.python').get_pylsp_settings()
            if is_python2() then
                default_opts.filetypes = {'notpython2'}
            end
            return default_opts
        end,
        ["yamlls"] = function ()
            default_opts = make_config()
            default_opts.settings = require('config.servers.yaml').get_settings()
            return default_opts
        end,
    }

    -- We check to see if any custom server_opts exist for the LSP server, if so, load them, if not, use our default_opts
    server:setup(server_opts[server.name] and server_opts[server.name]() or default_opts)
    vim.cmd([[ do User LspAttachBuffers ]])
end)

M = {}
M.make_config = make_config

return M
