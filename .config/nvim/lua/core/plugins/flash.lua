M = {
	"folke/flash.nvim",
	event = "VeryLazy",
	opts = {},
  -- stylua: ignore
  keys = {
    { "<localleader>f", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    { "<localleader>T", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
  },
}

return M
