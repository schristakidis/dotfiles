local M = {
  'svermeulen/vim-yoink',
  dependencies = {
    'svermeulen/vim-cutlass',
    'svermeulen/vim-subversive',
  },
  init = function ()
    -- vim.cmd([[ let g:yoinkIncludeDeleteOperations = 1 ]])
    -- vim.cmd([[ let g:yoinkSavePersistently = 1 ]])
    -- vim.cmd([[ let g:yoinkSwapClampAtEnds = 0 ]])
    -- vim.cmd([[ let g:yoinkAutoFormatPaste = 1 ]])
    vim.g.yoinkIncludeDeleteOperations = 1
    vim.g.yoinkSavePersistently = 1
    vim.g.yoinkSwapClampAtEnds = 0
    vim.g.yoinkAutoFormatPaste = 1
  end,
  lazy = false,
  config = function()
    vim.keymap.set("n", "gm", "m")
    vim.keymap.set({ "x", "n" }, "m", "d")
    vim.keymap.set("n", "mm", "dd")
    vim.keymap.set("n", "M", "D")
    vim.keymap.set('n', "p", "<plug>(YoinkPaste_p)", { remap = true })
    vim.keymap.set('n', "P", "<plug>(YoinkPaste_P)", { remap = true })
    vim.keymap.set('n', "<leader>yp", "<plug>(YoinkPostPasteSwapBack)", { remap = true })
    vim.keymap.set('n', "<leader>yn", "<plug>(YoinkPostPasteSwapForward)", { remap = true })
    vim.keymap.set('n', "<localleader>p", "<plug>(YoinkPostPasteToggleFormat)", { remap = true })
    vim.keymap.set({ 'n', 'x' }, "s", "<plug>(SubversiveSubstitute)", { remap = true })
    vim.keymap.set('x', "p", "<plug>(SubversiveSubstitute)", { remap = true })
    vim.keymap.set('x', "P", "<plug>(SubversiveSubstitute)", { remap = true })
    vim.keymap.set('n', "ss", "<plug>(SubversiveSubstituteLine)", { remap = true })
    vim.keymap.set('n', "S", "<plug>(SubversiveSubstituteToEndOfLine)", { remap = true })
    vim.keymap.set({ 'n', 'x' }, "<leader>s", "<plug>(SubversiveSubstituteRange)", { remap = true })
    vim.keymap.set('n', "<leader>ss", "<plug>(SubversiveSubstituteWordRange)", { remap = true })
  end
}

return M
