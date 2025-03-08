local M = {
  'milanglacier/minuet-ai.nvim',
  config = function()
    require('minuet').setup {
      provider = 'gemini',
      provider_options = {
        gemini = {
          model = 'gemini-2.0-flash',
          -- system = "see [Prompt] section for the default value",
          -- few_shots = "see [Prompt] section for the default value",
          -- chat_input = "See [Prompt Section for default value]",
          stream = true,
          api_key = 'GEMINI_API_KEY',
          optional = {},
        },
      }
    }
  end,
  dependencies = {
    'nvim-lua/plenary.nvim',
    'hrsh7th/nvim-cmp',
  }
}


return M
