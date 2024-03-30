local M = {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v2.x",
  cmd = "Neotree",
  keys = {"<leader>nt", "<leader>nb", "<leader>ng"},
  dependencies = {
    "nvim-lua/plenary.nvim",
    "kyazdani42/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function ()
    vim.keymap.set('n', '<leader>nt', "<cmd>Neotree toggle<CR>")
    vim.keymap.set('n', '<leader>nb', "<cmd>Neotree buffers float toggle<CR>")
    vim.keymap.set('n', '<leader>ng', "<cmd>Neotree git_status float toggle<CR>")
  end
}

return M
