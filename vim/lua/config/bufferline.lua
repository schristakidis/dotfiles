require("bufferline").setup{
    options = {
        -- numbers = "buffer_id",
        numbers = "ordinal",
        indicator = {
            style = 'none'
        },
        show_buffer_close_icons = false,
        always_show_bufferline = false
    }
}

local goto_buffer = function(pos)
    return function() require("bufferline").go_to_buffer(pos, true) end
end

local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<leader>1', goto_buffer(1), opts)
vim.keymap.set('n', '<leader>2', goto_buffer(2), opts)
vim.keymap.set('n', '<leader>3', goto_buffer(3), opts)
vim.keymap.set('n', '<leader>4', goto_buffer(4), opts)
vim.keymap.set('n', '<leader>5', goto_buffer(5), opts)
vim.keymap.set('n', '<leader>6', goto_buffer(6), opts)
vim.keymap.set('n', '<leader>7', goto_buffer(7), opts)
vim.keymap.set('n', '<leader>8', goto_buffer(8), opts)
vim.keymap.set('n', '<leader>9', goto_buffer(9), opts)

vim.api.nvim_create_user_command(
    'B',
    function(opt)
        require("bufferline").go_to_buffer(opt.args, true)
    end,
    { nargs = 1 }
)
