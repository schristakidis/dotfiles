local map = vim.keymap.set

-- Disable annoying Ex mode
map("n", "Q", "<Nop>")
map({ "n", "x" }, "q:", "<Nop>")

-- nnoremap n nzzzv
-- nnoremap N Nzzzv
-- nnoremap J mzJ`z
-- nnoremap <C-d> <C-d>zz
-- nnoremap <C-u> <C-u>zz

map("n", "<Space>", ":nohlsearch<Bar>:echo<CR>", { silent = true })
map("n", "<space><space>x", "<cmd>source %<CR>")
map("v", "<space>x", ":lua<CR>")

-- Copy to primary registry'
map("v", "<A-c>", "\"+y")
-- map("v", "<A-p>", "\"+y")
map({ "n", "v" }, "<A-p>", "\"+p")
-- Select all text
map("n", "<C-a>", "ggVG")
--
--
-- " close scratch buferr
-- noremap <C-q> <C-W>z
--
-- " Close location window also with :bd
-- " nnoremap <silent> <C-d> :lclose<CR>:bdelete<CR>
-- cabbrev <silent> bd <C-r>=(getcmdtype()==#':' && getcmdpos()==1 ? 'lclose\|bdelete' : 'bd')<CR>
--
-- noremap U <C-R>
--
-- map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
-- \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
-- \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

vim.api.nvim_create_user_command(
    'YamlSchemas',
    function()
        require('user.additional-schemas').init()
    end,
    { nargs = 0 }
)

vim.api.nvim_create_user_command(
    'YamlSchemaAuto',
    function()
        require('user.additional-schemas').init_advanced()
    end,
    { nargs = 0 }
)

vim.keymap.set(
    'n', '<leader>s',
    function()
        require('user.additional-schemas').init_advanced()
    end,
    { noremap = true, silent = true }
)

