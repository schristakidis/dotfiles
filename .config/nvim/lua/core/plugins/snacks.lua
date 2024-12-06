M = {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    git = { enabled = true },
    lazygit = { enabled = true },
    notifier = {
      level = vim.log.levels.WARN,
    },
    styles = {
      notification = {
        wo = { wrap = true } -- Wrap notifications
      }
    },
  },
  keys = {
      { "<leader>n",  function() Snacks.notifier.show_history() end, desc = "Notification History" },
      { "<localleader>gb", function() Snacks.git.blame_line() end, desc = "Git Blame Line" },
      { "<localleader>gf", function() Snacks.lazygit.log_file() end, desc = "Lazygit Current File History" },
      { "<localleader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
      { "<localleader>gl", function() Snacks.lazygit.log() end, desc = "Lazygit Log (cwd)" },
      { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },
    },
}

return M
