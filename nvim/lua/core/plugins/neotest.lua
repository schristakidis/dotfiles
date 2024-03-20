M = {
  "nvim-neotest/neotest",
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-neotest/neotest-python',
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "antoinemadec/FixCursorHold.nvim",
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-python")({
          python = "python"
        })
      }
    })


    local opts = { noremap = true, silent = true }
    -- Run test
    vim.keymap.set(
      'n', '<localleader>tt',
      function() require('neotest').run.run() end, opts
    )
    -- Run file
    vim.keymap.set(
      'n', '<localleader>tf',
      function() require('neotest').run.run(vim.fn.expand('%')) end, opts
    )
    -- Run last
    vim.keymap.set(
      'n', '<localleader>tl',
      function() require('neotest').run.run_last() end, opts
    )
    -- Attach Test
    vim.keymap.set(
      'n', '<localleader>ta',
      function() require('neotest').run.attach() end, opts
    )
    -- Stop test
    vim.keymap.set(
      'n', '<localleader>tS',
      function() require('neotest').run.run_stop() end, opts
    )
    -- Open output
    vim.keymap.set(
      'n', '<localleader>to',
      function() require('neotest').output.open({ enter = true }) end, opts
    )
    -- Toggle output panel
    vim.keymap.set(
      'n', '<localleader>tp',
      function() require('neotest').output_panel.toggle() end, opts
    )
    -- Toggle summary
    vim.keymap.set(
      'n', '<localleader>ts',
      function() require('neotest').summary.toggle() end, opts
    )
  end
}

return M
