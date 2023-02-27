local M = {
  "kevinhwang91/nvim-bqf",
  dependencies = {
    "junegunn/fzf",
  },
  ft = "qf",
  opts = {
    auto_enable = true,
    auto_resize_height = true,
    preview = {
      auto_preview = false,
    },
  },
}

return M

