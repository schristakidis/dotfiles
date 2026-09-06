M = {
  'numToStr/Comment.nvim',
  config = function()
    local ft = require('Comment.ft')
    ft
    .set('conf', '#%s')
    -- .set('conf', '#%s')
  end,
  opts = {
    mappings = {
      basic = true,
      extra = false
    }
  }
}

return M
