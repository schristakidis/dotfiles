local settings = require("core.settings")
local o = vim.opt
local fn = vim.fn

o.syntax = "on"
o.showmode = false
                                   -- filetype plugin indent on
o.iskeyword = o.iskeyword + '-'    -- treat dash separated words as a word text object"
o.hidden = true                    -- Required to keep multiple buffers open multiple buffers
o.encoding = "utf-8"               -- The encoding displayed
o.guicursor = ''
o.termguicolors = true

o.smartindent = true               -- Makes indenting smart
o.autoindent = true                -- Good auto indent
o.laststatus = 2                   -- Always display the status line
o.cursorline = true                -- Enable highlighting of the current line
o.background = "dark"              -- tell vim what the background color looks like
o.backup = false
o.shortmess = o.shortmess + "c"    -- Don't pass messages to |ins-completion-menu|.
o.signcolumn = "yes"
o.updatetime = 250                 -- Faster completion
o.completeopt = 'menuone,noselect'
o.hlsearch = true
o.incsearch = true
o.ignorecase = true
o.smartcase = true
o.title = true
o.autochdir = true                 -- automatically change window's cwd to file's dir
o.backspace = "indent,eol,start"
o.clipboard = "unnamed"            -- or "unnamedplus" ?
o.showmatch = true                 -- Show matching brackets when text indicator is over them
o.mat = 2                          -- How many tenths of a second to blink when matching brackets
o.inccommand = "nosplit"

o.list = settings.list
o.listchars = settings.listchars

o.scrolloff = 3                    -- Minimal number of screen lines to keep above and below the cursor
o.sidescrolloff = 5                -- The minimal number of columns to scroll horizontally

o.foldmethod = "indent"
o.foldignore = ""
o.foldenable = true
o.foldlevel = 99

o.tabstop = 4
o.shiftwidth = 4
o.softtabstop = 4
o.expandtab = true
o.smarttab = true                  -- Makes tabbing smarter will realize you have 2 vs 4
o.wrap = false

local numtogGrp = vim.api.nvim_create_augroup("NumberToggle", { clear = true })
vim.api.nvim_create_autocmd(
	{ "BufEnter", "InsertLeave", "FocusGained", "WinEnter" },
	{
		pattern = "*",
        command = [[ if &nu && mode() != "i" | set rnu   | endif ]],
		group = numtogGrp,
		desc = "Turn on relative line numbering when the buffer is entered.",
	}
)
vim.api.nvim_create_autocmd(
	{ "BufLeave", "InsertEnter", "FocusLost", "WinLeave" },
	{
		pattern = "*",
		command = "set norelativenumber",
		group = numtogGrp,
		desc = "Turn off relative line numbering when the buffer is exited.",
	}
)

vim.api.nvim_create_autocmd(
  { 'TextYankPost' }, {
  group = vim.api.nvim_create_augroup('highlight_yank', { clear = true }),
  desc = 'Hightlight selection on yank',
  pattern = '*',
  callback = function()
    vim.highlight.on_yank { higroup = 'IncSearch', timeout = 100 }
  end,
})


if not vim.env.SSH_TTY and not vim.env.XDG_SESSION_TYPE == 'wayland' then
  vim.cmd([[ let g:clipboard = {
      \ 'name': 'xsel_override',
      \ 'copy': {
      \     '+': 'xsel --input --clipboard',
      \     '*': 'xsel --input --primary',
      \ },
      \ 'paste': {
      \     '+': 'xsel --output --clipboard',
      \     '*': 'xsel --output --primary',
      \ },
      \ 'cache_enabled': 1,
  \ } ]])
end


vim.opt.dir = fn.stdpath("data") .. "/swp"
vim.opt.undodir = fn.stdpath("data") .. "/undodir"
--
--
-- " open quickfix window after grep commands
-- augroup my_quickfix_window
--     autocmd!
--     autocmd QuickFixCmdPost *grep* cwindow
-- augroup END
--
