local settings = require("core.settings")

if settings.theme == "onedark" then
  return {
    "navarasu/onedark.nvim",
    priority = 1000,
    lazy = false,
    config = function()
      require("onedark").load()
    end,
  }
elseif settings.theme == "nightfox" then
  return {
    "EdenEast/nightfox.nvim",
    priority = 1000,
    lazy = false,
    config = function()
      require("core.plugins.themes.nightfox")
    end,
  }
elseif settings.theme == "tundra" then
  return {
    "sam4llis/nvim-tundra",
    priority = 1000,
    lazy = false,
    config = function()
      require("core.plugins.themes.tundra")
    end,
  }
elseif settings.theme == "tokyonight" then
  return {
    "folke/tokyonight.nvim",
    priority = 1000,
    lazy = false,
    branch = "main",
    config = function()
      require("core.plugins.themes.tokyonight")
    end,
  }
elseif settings.theme == "kanagawa" then
  return {
    "rebelot/kanagawa.nvim",
    priority = 1000,
    lazy = false,
    config = function()
      require("core.plugins.themes.kanagawa")
    end,
  }
else
  return {
    "catppuccin/nvim",
    priority = 1000,
    lazy = false,
    name = "catppuccin",
    config = function()
      require("core.plugins.themes.catppuccin")
    end,
  }
end
