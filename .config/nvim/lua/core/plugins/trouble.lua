M = {
  'folke/trouble.nvim',
  config = function()
    require('trouble').setup()

    local opts = { silent = true, noremap = true }
    vim.keymap.set("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>", opts)

    vim.keymap.set("n", "<leader>xx", "<cmd>Trouble document_diagnostics<cr>", opts)

    vim.keymap.set("n", "<leader>xl", "<cmd>Trouble loclist<cr>", opts)

    vim.keymap.set("n", "<leader>xq", "<cmd>Trouble quickfix<cr>", opts)

    vim.keymap.set("n", "gr", "<cmd>Trouble lsp_references<cr>", opts)
  end
}

return M
