M = {
  'folke/trouble.nvim',
  config = function()
    require('trouble').setup()

    local opts = { silent = true, noremap = true }
    vim.keymap.set("n", "<localleader>xw", "<cmd>Trouble diagnostics toggle<cr>", opts)

    vim.keymap.set("n", "<localleader>xx", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", opts)

    vim.keymap.set("n", "<localleader>xs", "<cmd>Trouble symbols toggle focus=false<cr>", opts)

    vim.keymap.set("n", "<localleader>xr", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", opts)
  end
}

return M
