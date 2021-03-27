local saga = require 'lspsaga'

vim.api.nvim_set_keymap(
    'n', 'gsk',
    [[<Cmd>lua require('lspsaga.hover').render_hover_doc()<CR>]],
    { noremap = true, silent = true }
)

-- vim.api.nvim_set_keymap(
--     'n', '<C-f>',
--     [[<Cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>]],
--     { noremap = true, silent = true }
-- )
--
-- vim.api.nvim_set_keymap(
--     'n', '<C-b>',
--     [[<Cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>]],
--     { noremap = true, silent = true }
-- )
--
vim.api.nvim_set_keymap(
    'n', 'gsh',
    [[<Cmd>lua require('lspsaga.provider').lsp_finder()<CR>]],
    { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
    'n', 'gsd',
    [[<Cmd>lua require('lspsaga.provider').preview_definition()<CR>]],
    { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
    'n', 'gss',
    [[<Cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>]],
    { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
    'n', '<leader>cd',
    [[<Cmd>lua require('lspsaga.diagnostic').show_line_diagnostics()<CR>]],
    { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
    'n', '<leader>cc',
    [[<Cmd>lua require('lspsaga.diagnostic').show_cursor_diagnostics()<CR>]],
    { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
    'n', ']e',
    [[<Cmd>lua require('lspsaga.diagnostic').lsp_jump_diagnostic_next()<CR>]],
    { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
    'n', '[e',
    [[<Cmd>lua require('lspsaga.diagnostic').lsp_jump_diagnostic_prev()<CR>]],
    { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
    'n', 'ca',
    [[<Cmd>lua require('lspsaga.codeaction').code_action()<CR>]],
    { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
    'v', 'ca',
    [[<C-U>lua require('lspsaga.codeaction').range_code_action()<CR>]],
    { noremap = true, silent = true }
)

saga.init_lsp_saga {
    -- add your config value here
    -- default value
    use_saga_diagnostic_sign = true,
    error_sign = '',
    warn_sign = '',
    hint_sign = '',
    infor_sign = '',
    dianostic_header_icon = '   ',
    code_action_icon = ' ',
    code_action_prompt = {
      enable = true,
      sign = true,
      sign_priority = 20,
      virtual_text = true,
    },
    finder_definition_icon = '  ',
    finder_reference_icon = '  ',
    max_preview_lines = 10, -- preview lines of lsp_finder and definition preview
    finder_action_keys = {
      open = 'o', vsplit = 's',split = 'i',quit = 'q',scroll_down = '<C-f>', scroll_up = '<C-b>' -- quit can be a table
    },
    code_action_keys = {
      quit = 'q',exec = '<CR>'
    },
    rename_action_keys = {
      quit = '<C-c>',exec = '<CR>'  -- quit can be a table
    },
    definition_preview_icon = '  ',
    -- 1: thin border | 2: rounded border | 3: thick border | 4: ascii border
    border_style = 1,
    rename_prompt_prefix = '➤',
    -- if you don't use nvim-lspconfig you must pass your server name and
    -- the related filetypes into this table
    -- like server_filetype_map = {metals = {'sbt', 'scala'}}
    -- server_filetype_map = {}
}
