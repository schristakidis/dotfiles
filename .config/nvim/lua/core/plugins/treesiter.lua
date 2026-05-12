vim.api.nvim_create_autocmd({ 'Filetype' }, {
  callback = function(event)
    -- make sure nvim-treesitter is loaded
    local ok, nvim_treesitter = pcall(require, 'nvim-treesitter')

    -- no nvim-treesitter, maybe fresh install
    if not ok then return end

    local parsers = require('nvim-treesitter.parsers')

    if not parsers[event.match] or not nvim_treesitter.install then return end

    local ft = vim.bo[event.buf].ft
    local lang = vim.treesitter.language.get_lang(ft)
    nvim_treesitter.install({ lang }):await(function(err)
      if err then
        vim.notify('Treesitter install error for ft: ' .. ft .. ' err: ' .. err)
        return
      end

      pcall(vim.treesitter.start, event.buf)
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    end)
  end,
})

local M = {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        build = function()
            if vim.fn.exists(':TSUpdate') == 2 then vim.cmd('TSUpdate') end
        end,
        -- event = "BufReadPost",
        dependencies = {
            -- "nvim-treesitter/nvim-treesitter-textobjects",
            "RRethy/nvim-treesitter-endwise",
            "mfussenegger/nvim-ts-hint-textobject",
            "windwp/nvim-ts-autotag",
            -- "nvim-treesitter/playground",
        },
        config = function(_, _)
            local ensure_installed = {
                "c", "lua", "vim", "vimdoc", "query", "python", "go", "terraform", "yaml",
                "dockerfile", "json", "markdown", "markdown_inline", "gotmpl", "gowork", "gomod",
                "gosum", "sql", "comment"
            }
            local ok, nvim_treesitter = pcall(require, 'nvim-treesitter')
            if not ok then return end
            nvim_treesitter.install(ensure_installed)
        end,
    },
    {
        'nvim-treesitter/nvim-treesitter-textobjects',
        event = 'VeryLazy',
        branch = 'main',
          init = function()
            vim.g.no_plugin_maps = true
          end,
          config = function()
            require("nvim-treesitter-textobjects").setup {
              select = {
                lookahead = true,
                include_surrounding_whitespace = false,
              },
            }

            vim.keymap.set({ "x", "o" }, "af", function()
                require "nvim-treesitter-textobjects.select".select_textobject("@function.outer", "textobjects")
            end)
            vim.keymap.set({ "x", "o" }, "if", function()
                require "nvim-treesitter-textobjects.select".select_textobject("@function.inner", "textobjects")
            end)
            vim.keymap.set({ "x", "o" }, "ac", function()
                require "nvim-treesitter-textobjects.select".select_textobject("@class.outer", "textobjects")
            end)
            vim.keymap.set({ "x", "o" }, "ic", function()
                require "nvim-treesitter-textobjects.select".select_textobject("@class.inner", "textobjects")
            end)
            vim.keymap.set({ "x", "o" }, "ab", function()
                require "nvim-treesitter-textobjects.select".select_textobject("@block.outer", "textobjects")
            end)
            vim.keymap.set({ "x", "o" }, "ib", function()
                require "nvim-treesitter-textobjects.select".select_textobject("@block.inner", "textobjects")
            end)

            vim.keymap.set({ "n", "x", "o" }, "[f", function()
                require "nvim-treesitter-textobjects.move".goto_previous_start("@function.outer", "textobjects")
            end)

            vim.keymap.set({ "n", "x", "o" }, "]f", function()
                require "nvim-treesitter-textobjects.move".goto_next_start("@function.outer", "textobjects")
            end)

          end,
    }
}



return M
