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

-- lsp-install
local function setup_servers()
    require'lspinstall'.setup()

    -- get all installed servers
    local servers = require'lspinstall'.installed_servers()
    -- print(vim.inspect(servers))
    -- ... and add manually installed servers
    table.insert(servers, "pylsp")

    for _, server in pairs(servers) do
        -- print(server)
        local config = make_config()

        -- language specific config
        if server == "lua" then
            config.settings = require('config.servers.lua').get_settings()
        end
        if server == "pylsp" then
            config.cmd = { "pylsp" }
            config.settings = require('config.servers.python').get_pylsp_settings()
        end
        if server == "python" then
            config.settings = require('config.servers.python').get_pyright_settings()
        end
        if server == "yaml" then
            config.settings = require('config.servers.yaml').get_settings()
        end
        -- if server == "diagnosticls" then
            --     config.init_options = require('config.servers.diagnostics').get_settings()
            --     config.filetypes = { "python" }
        -- end

        require'lspconfig'[server].setup(config)
    end
end

setup_servers()

-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
require'lspinstall'.post_install_hook = function ()
    setup_servers() -- reload installed servers
    vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
end

M = {}
M.make_config = make_config

return M
