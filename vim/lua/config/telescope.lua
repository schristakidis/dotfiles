vim.api.nvim_set_keymap(
    'n', '<C-p>',
    [[<Cmd>lua require('config.telescope').project_files()<CR>]],
    { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
    'n', '<C-f>',
    [[<Cmd>lua require('telescope.builtin').find_files()<CR>]],
    { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
    'n', '<C-b>',
    [[<Cmd>lua require('telescope.builtin').buffers()<CR>]],
    { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
    'n', '<leader>vo',
    [[<Cmd>lua require('config.telescope').search_dotfiles()<CR>]],
    { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
    'n', '<C-g>',
    [[<Cmd>lua require('config.telescope').git_grep()<CR>]],
    { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
    'n', "<leader>\\",
    [[<Cmd>lua require('config.telescope').git_live_grep()<CR>]],
    { noremap = true, silent = true }
)


local actions = require('telescope.actions')
require('telescope').setup {
    defaults = {
        file_sorter = require('telescope.sorters').get_fzy_sorter,
        prompt_prefix = ' 🔍 ',
        color_devicons = true,

        -- transaparency (0 - 100)
        winblend = 10,
        use_less = true,

        file_previewer   = require('telescope.previewers').vim_buffer_cat.new,
        grep_previewer   = require('telescope.previewers').vim_buffer_vimgrep.new,
        qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,

        mappings = {
            i = {
                ["<C-x>"] = false,
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
            },
            n = {
                ["v"] = actions.select_vertical
            },
        }
    },
    extensions = {
        fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true,
        }
    }
}

require('telescope').load_extension('fzy_native')

local M = {}

M.project_files = function()
    local opts = {} -- define here if you want to define something
    local ok = pcall(require'telescope.builtin'.git_files, opts)
    if not ok then require'telescope.builtin'.find_files(opts) end
end

M.git_grep = function() 
    local lsp = require 'lspconfig'
    require("telescope.builtin").grep_string({
        prompt_title = "< Git Grep >",
        cwd = lsp.util.root_pattern('.git')(vim.loop.cwd()),
        initial_mode = "normal"
    })
end

M.git_live_grep = function() 
    local lsp = require 'lspconfig'
    require("telescope.builtin").live_grep({
        prompt_title = "< Git Live Grep >",
        cwd = lsp.util.root_pattern('.git')(vim.loop.cwd())
    })
end

M.search_dotfiles = function() 
    local lsp = require 'lspconfig'
    require("telescope.builtin").find_files({
        prompt_title = "< VimRC >",
        cwd = "$HOME/.dotfiles/vim"
    })
end


M.git_branches = function()
    require("telescope.builtin").git_branches({
        attach_mappings = function(_, map)
            map('i', '<c-d>', actions.git_delete_branch)
            map('n', '<c-d>', actions.git_delete_branch)
            return true
        end
    })
end

return M
