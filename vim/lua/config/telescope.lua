require("telescope").setup {
  defaults = {
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "-."
    }
  }
}
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

vim.api.nvim_set_keymap(
    'n', "z=",
    [[<Cmd>lua require('telescope.builtin').spell_suggest()<CR>]],
    { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
    'n', "<leader>r",
    [[<Cmd>lua require('telescope.builtin').resume()<CR>]],
    { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
    'n', "<leader>ott",
    [[<Cmd>:Telescope terraform_doc<CR>]],
    { noremap = true, silent = true }
)


local actions = require('telescope.actions')
require('telescope').setup {
    defaults = {
        file_sorter = require('telescope.sorters').get_fzy_sorter,
        prompt_prefix = ' 🔍 ',

        winblend = 10,

        mappings = {
            i = {
                -- ["<C-x>"] = false,
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
            },
            n = {
                ["v"] = actions.select_vertical
            },
        }
    },
    pickers = {
        buffers = {
            sort_lastused = true,
            theme = "dropdown",
            previewer = false,
            initial_mode = "normal",
            mappings = {
                i = {
                    -- ["<c-d>"] = require("telescope.actions").delete_buffer,
                    -- -- Right hand side can also be the name of the action as a string
                    ["<c-d>"] = "delete_buffer",
                },
                n = {
                    ["<c-d>"] = require("telescope.actions").delete_buffer,
                }
            }
        },
        spell_suggest = {
            theme = "dropdown",
            initial_mode = "normal"
        }
    },
    extensions = {
        -- fzy_native = {
        --     override_generic_sorter = false,
        --     override_file_sorter = true,
        -- },
        fzf = {
            fuzzy = true,                    -- false will only do exact matching
            override_generic_sorter = true,  -- override the generic sorter
            override_file_sorter = true,     -- override the file sorter
            case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
        },
        terraform_doc = {
            url_open_command = "xdg-open",
            latest_provider_symbol = "  ",
            wincmd = "botright vnew",
            wrap = "nowrap",
        }
    }
}

-- require('telescope').load_extension('fzy_native')
require('telescope').load_extension('fzf')
require('telescope').load_extension('terraform_doc')
require("telescope").load_extension("yaml_schema")

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
        cwd = lsp.util.find_git_ancestor(vim.loop.cwd()),
        initial_mode = "insert"
    })
end

M.git_live_grep = function()
    local lsp = require 'lspconfig'
    require("telescope.builtin").live_grep({
        prompt_title = "< Git Live Grep >",
        cwd = lsp.util.find_git_ancestor(vim.loop.cwd()),
    })
end

M.search_dotfiles = function()
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
