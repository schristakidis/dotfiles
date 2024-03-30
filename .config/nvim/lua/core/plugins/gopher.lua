local M = {
    "olexsmir/gopher.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    ft = "go",
    build =  function ()
        vim.cmd [[silent! GoInstallBinaries]]
    end
}

return M
