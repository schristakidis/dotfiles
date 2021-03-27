vim.api.nvim_set_option('completeopt', 'menuone,noinsert,noselect')
vim.g.completion_auto_change_source = 1

vim.api.nvim_set_keymap(
    'i', '<Tab>',
    'pumvisible() ? "<C-n>" : "<Tab>"',
    { expr = true, noremap = true}
)

vim.api.nvim_set_keymap(
    'i', '<S-Tab>',
    'pumvisible() ? "<C-n>" : "<S-Tab>"',
    { expr = true, noremap = true}
)

vim.api.nvim_set_keymap(
    'i', '<Tab>',
    '<Plug>(completion_smart_tab)', {}
)

-- This is not working properly. there's a problem with highlite groups and tree sitter. This is all wild guesses
local chain_complete_list = {
    default = {
        default = {
            {complete_items = {'lsp'}},
            {complete_items = {'path'}}, --, triggered_only = {'/'}},
            {mode = '<c-n>'}
        },
        string = {
            {complete_items = {'path'}}
        },
        comment = {
            {complete_items = {'lsp'}},
            {complete_items = {'path'}, triggered_only = {'/'}},
        },
    }
}

-- keymaps
local on_attach = function(client, bufnr)
  -- require('completion').on_attach()
  require('completion').on_attach({
      sorting = 'alphabet',
      matching_strategy_list = {'exact', 'substring', 'fuzzy'},
      completion_matching_smart_case = true,
      chain_complete_list = chain_complete_list,
      trigger_keyword_length = 2,
  })

  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', '<leader>g', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', '<leader>d', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<leader>i', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  -- buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  -- buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  -- buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  -- buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  -- buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  elseif client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
    augroup lsp_document_highlight
    autocmd! * <buffer>
    autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
    autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
    augroup END
    ]], false)
  end
end

-- Configure lua language server for neovim development
local lua_settings = {
  Lua = {
    runtime = {
      -- LuaJIT in the case of Neovim
      version = 'LuaJIT',
      path = vim.split(package.path, ';'),
    },
    diagnostics = {
      -- Get the language server to recognize the `vim` global
      globals = {'vim'},
    },
    workspace = {
      -- Make the server aware of Neovim runtime files
      library = {
        [vim.fn.expand('$VIMRUNTIME/lua')] = true,
        [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
      },
    },
  }
}

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
  -- ... and add manually installed servers
  -- table.insert(servers, "lua")
  -- table.insert(servers, "python")
  -- table.insert(servers, "yaml")
  -- table.insert(servers, "bash")
  -- table.insert(servers, "dockerfile")
  table.insert(servers, "pyls")

  for _, server in pairs(servers) do
    local config = make_config()

    -- language specific config
    if server == "lua" then
      config.settings = lua_settings
    end
    if server == "pyls" then
        config.cmd = { "pyls", '--log-file', '/tmp/pyls-log.txt' }
        config.settings = pyls_settings
    end

    require'lspconfig'[server].setup(config)
  end
end

setup_servers()

-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
require'lspinstall'.post_install_hook = function ()
  setup_servers() -- reload installed servers
  vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
end
