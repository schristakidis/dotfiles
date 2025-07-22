local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument.foldingRange = {
  dynamicRegistration = true,
  lineFoldingOnly = true,
}

capabilities.textDocument.semanticTokens.multilineTokenSupport = true
capabilities.textDocument.completion.completionItem.snippetSupport = true

vim.lsp.config("*", {
  capabilities = capabilities,
})

require("mason").setup()


vim.lsp.enable('pyright')
vim.lsp.enable('pylsp')
vim.lsp.enable('lua_ls')
vim.lsp.enable('terraformls')
vim.lsp.enable('bashls')
vim.lsp.enable('dockerls')
vim.lsp.enable('helmls')
vim.lsp.enable('gopls')

local cfg = require("yaml-companion").setup({
  on_new_config = function(new_config)
    new_config.settings.yaml.schemas = vim.tbl_deep_extend(
      "force",
      new_config.settings.yaml.schemas or {},
      require("schemastore").yaml.schemas()
    )
  end,
  lspconfig = {
    capabilities = capabilities
  },
  settings = {
    redhat = { telemetry = { enabled = false } },
    yaml = {
      keyOrdering = false,
      format = {
        enable = true,
      },
      validate = true,
      schemaStore = {
        -- Must disable built-in schemaStore support to use
        -- schemas from SchemaStore.nvim plugin
        enable = false,
        -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
        url = "",
      },
      schemas = require('schemastore').yaml.schemas(),
    },
  },
})
require("lspconfig")["yamlls"].setup(cfg)

vim.diagnostic.config({
  virtual_lines = false,
  -- virtual_text = true,
  virtual_text = {
    source = false,
    prefix = '■',
    current_line = true,
    -- Only show virtual text matching the given severity
    -- severity = {
    --   -- Specify a range of severities
    --   min = vim.diagnostic.severity.ERROR,
    -- },
  },
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = "rounded",
    source = true,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "󰅚 ",
      [vim.diagnostic.severity.WARN] = "󰀪 ",
      [vim.diagnostic.severity.INFO] = "󰋽 ",
      [vim.diagnostic.severity.HINT] = "󰌶 ",
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = "ErrorMsg",
      [vim.diagnostic.severity.WARN] = "WarningMsg",
    },
  },
})


vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local bufnr = ev.buf
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if not client then
      return
    end

    -- Mappings.
    local bufopts = { noremap = true, silent = true, buffer = bufnr }


    local opts = { noremap = true, silent = true }
    vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '[e', function() vim.diagnostic.jump({ count = 1, float = true, severity = "WARN" }) end, opts)
    vim.keymap.set('n', ']e', function() vim.diagnostic.jump({ count =-1, float = true, severity = "WARN" }) end, opts)
    vim.keymap.set('n', '[d', function() vim.diagnostic.jump({ count = 1, float = true }) end, opts)
    vim.keymap.set('n', ']d', function() vim.diagnostic.jump({ count =-1, float = true }) end, opts)
    vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
    vim.keymap.set("n", "<localleader>tv", function() vim.diagnostic.config({ virtual_lines = not vim.diagnostic.config().virtual_lines }) end, opts)

    vim.keymap.set('n', '<leader>g', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', '<leader>d', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', '<leader>i', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<localleader>sh', vim.lsp.buf.signature_help, bufopts)

    vim.keymap.set('n', 'gR', vim.lsp.buf.references, bufopts)

    vim.keymap.set('n', '<leader>ss', function() require('telescope.builtin').lsp_document_symbols() end, bufopts)
    -- vim.keymap.set('n', '=', function() vim.lsp.buf.format { timeout_ms = 2000, async = true } end, bufopts)
    -- vim.keymap.set('v', '=', function() vim.lsp.buf.format { timeout_ms = 2000, async = true } end, bufopts)

    vim.keymap.set('n', '<localleader>ll', vim.cmd.LspRestart, bufopts)
    vim.keymap.set('n', '<localleader>li', vim.cmd.LspInfo, bufopts)

    if client.server_capabilities.completionProvider then
      vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
    end

    if client.server_capabilities.definitionProvider then
      vim.bo[bufnr].tagfunc = "v:lua.vim.lsp.tagfunc"
    end

  end
})


-- vim.api.nvim_create_user_command("LspInfo", function()
--   vim.cmd("silent checkhealth vim.lsp")
-- end, {
--   desc = "Get all the information about all LSP attached",
-- })
--
-- vim.api.nvim_create_user_command("LspStart", function()
--   vim.cmd.e()
-- end, { desc = "Starts LSP clients in the current buffer" })
--
-- vim.api.nvim_create_user_command("LspStop", function(opts)
--   for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
--     if opts.args == "" or opts.args == client.name then
--       client:stop(true)
--       vim.notify(client.name .. ": stopped")
--     end
--   end
-- end, {
--   desc = "Stop all LSP clients or a specific client attached to the current buffer.",
--   nargs = "?",
--   complete = function(_, _, _)
--     local clients = vim.lsp.get_clients({ bufnr = 0 })
--     local client_names = {}
--     for _, client in ipairs(clients) do
--       table.insert(client_names, client.name)
--     end
--     return client_names
--   end,
-- })
--
-- vim.api.nvim_create_user_command("LspRestart", function()
--   local detach_clients = {}
--   for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
--     client:stop(true)
--     if vim.tbl_count(client.attached_buffers) > 0 then
--       detach_clients[client.name] = { client, vim.lsp.get_buffers_by_client_id(client.id) }
--     end
--   end
--   local timer = vim.uv.new_timer()
--   if not timer then
--     return vim.notify("Servers are stopped but havent been restarted")
--   end
--   timer:start(
--     100,
--     50,
--     vim.schedule_wrap(function()
--       for name, client in pairs(detach_clients) do
--         local client_id = vim.lsp.start(client[1].config, { attach = false })
--         if client_id then
--           for _, buf in ipairs(client[2]) do
--             vim.lsp.buf_attach_client(buf, client_id)
--           end
--           vim.notify(name .. ": restarted")
--         end
--         detach_clients[name] = nil
--       end
--       if next(detach_clients) == nil and not timer:is_closing() then
--         timer:close()
--       end
--     end)
--   )
-- end, {
--   desc = "Restart all the language client(s) attached to the current buffer",
-- })
--
-- vim.api.nvim_create_user_command("LspLog", function()
--   vim.cmd.vsplit(vim.lsp.log.get_filename())
-- end, {
--   desc = "Get all the lsp logs",
-- })
--
local function check_lsp_capabilities()
    local bufnr = vim.api.nvim_get_current_buf()
    local clients = vim.lsp.get_clients({ bufnr = bufnr })

    if #clients == 0 then
        print("No LSP clients attached")
        return
    end

    for _, client in ipairs(clients) do
        print("Capabilities for " .. client.name .. ":")
        local caps = client.server_capabilities

        local capability_list = {
            { "Completion",                caps.completionProvider },
            { "Hover",                     caps.hoverProvider },
            { "Signature Help",            caps.signatureHelpProvider },
            { "Go to Definition",          caps.definitionProvider },
            { "Go to Declaration",         caps.declarationProvider },
            { "Go to Implementation",      caps.implementationProvider },
            { "Go to Type Definition",     caps.typeDefinitionProvider },
            { "Find References",           caps.referencesProvider },
            { "Document Highlight",        caps.documentHighlightProvider },
            { "Document Symbol",           caps.documentSymbolProvider },
            { "Workspace Symbol",          caps.workspaceSymbolProvider },
            { "Code Action",               caps.codeActionProvider },
            { "Code Lens",                 caps.codeLensProvider },
            { "Document Formatting",       caps.documentFormattingProvider },
            { "Document Range Formatting", caps.documentRangeFormattingProvider },
            { "Rename",                    caps.renameProvider },
            { "Folding Range",             caps.foldingRangeProvider },
            { "Selection Range",           caps.selectionRangeProvider },
        }

        for _, cap in ipairs(capability_list) do
            local status = cap[2] and "✓" or "✗"
            print(string.format("  %s %s", status, cap[1]))
        end
        print("")
    end
end

vim.api.nvim_create_user_command('LspCapabilities', check_lsp_capabilities, { desc = "Show LSP capabilities" })
