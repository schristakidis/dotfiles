local M = {
  "nvim-telescope/telescope.nvim",
  -- cmd = "Telescope",
  dependencies = {
    'nvim-lua/plenary.nvim',
    'ANGkeith/telescope-terraform-doc.nvim',
    'someone-stole-my-name/yaml-companion.nvim',
    "crispgm/telescope-heading.nvim",
    "nvim-telescope/telescope-symbols.nvim",
    "nvim-telescope/telescope-file-browser.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
  },
  config = function()
    -- require('telescope').load_extension('fzy_native')
    require('telescope').load_extension('fzf')
    require('telescope').load_extension('terraform_doc')
    require('telescope').load_extension('ui-select')
    require('telescope').load_extension('heading')
    require("telescope").load_extension("yaml_schema")

    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local builtin = require("telescope.builtin")
    local fb_actions = require("telescope").extensions.file_browser.actions
    local vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "-."
    }
    telescope.setup({
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown({}),
        },
        file_browser = {
          theme = "ivy",
          hijack_netrw = false,
          hidden = true,
          mappings = {
            i = {
              ["<c-n>"] = fb_actions.create,
              ["<c-r>"] = fb_actions.rename,
              ["<c-h>"] = fb_actions.toggle_hidden,
              ["<c-x>"] = fb_actions.remove,
              ["<c-p>"] = fb_actions.move,
              ["<c-y>"] = fb_actions.copy,
              ["<c-a>"] = fb_actions.select_all,
            },
          },
        },
        fzf = {
          fuzzy = true, -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true, -- override the file sorter
          case_mode = "smart_case", -- or "ignore_case" or "respect_case"
        },
        terraform_doc = {
          url_open_command = "xdg-open",
          latest_provider_symbol = "  ",
          wincmd = "botright vnew",
          wrap = "nowrap",
        }
      },
      pickers = {
        buffers = {
          theme = "dropdown",
          ignore_current_buffer = true,
          previewer = false,
          initial_mode = "insert",
          mappings = {
            i = {
              ["<c-d>"] = "delete_buffer",
            },
            n = {
              ["<c-d>"] = actions.delete_buffer,
            }
          }
        },
        spell_suggest = {
          theme = "dropdown",
          initial_mode = "normal"
        }
      },
      defaults = {
        file_sorter = require('telescope.sorters').get_fzy_sorter,
        prompt_prefix = ' 🔍 ',
        vimgrep_arguments = vimgrep_arguments,

        winblend = 10,

        mappings = {
          i = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
          },
          n = {
            ["v"] = actions.select_vertical
          },
        }
      },
    })





    local project_files = function()
      local opts = {}
      local ok = pcall(builtin.git_files, opts)
      if not ok then builtin.find_files(opts) end
    end

    local git_grep = function()
      local lsp = require 'lspconfig'
      builtin.grep_string({
        prompt_title = "< Git Grep >",
        cwd = lsp.util.find_git_ancestor(vim.loop.cwd()),
        initial_mode = "insert"
      })
    end

    local git_live_grep = function()
      local lsp = require 'lspconfig'
      require("telescope.builtin").live_grep({
        prompt_title = "< Git Live Grep >",
        cwd = lsp.util.find_git_ancestor(vim.loop.cwd()),
      })
    end

    local search_dotfiles = function()
      builtin.find_files({
        prompt_title = "< VimRC >",
        cwd = "$HOME/.dotfiles/vim"
      })
    end


    -- local git_branches = function()
    --     builtin.git_branches({
    --         attach_mappings = function(_, map)
    --             map('i', '<c-d>', actions.git_delete_branch)
    --             map('n', '<c-d>', actions.git_delete_branch)
    --             return true
    --         end
    --     })
    -- end

    local opts = { noremap = true, silent = true }
    vim.keymap.set('n', '<C-p>', project_files, opts)
    vim.keymap.set('n', '<C-f>', builtin.find_files, opts)
    vim.keymap.set('n', '<C-b>', builtin.buffers, opts)
    vim.keymap.set('n', '<leader>vo', search_dotfiles, opts)
    vim.keymap.set('n', '<C-g>', git_grep, opts)
    vim.keymap.set('n', '<leader>\\', git_live_grep, opts)
    vim.keymap.set('n', 'z=', builtin.spell_suggest, opts)
    vim.keymap.set('n', '<leader>r', builtin.resume, opts)
    -- vim.keymap.set('n', '<leader>ott', builtin.resume, opts)
    --
    -- vim.api.nvim_set_keymap(
    --     'n', "<leader>ott",
    --     [[<Cmd>:Telescope terraform_doc<CR>]],
    --     { noremap = true, silent = true }
    -- )
  end
}

return M
