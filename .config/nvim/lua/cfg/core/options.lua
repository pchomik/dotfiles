-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Indentation settings
vim.o.expandtab = true -- Use spaces instead of tabs
vim.o.shiftwidth = 4 -- Number of spaces to use for each step of (auto)indent
vim.o.tabstop = 4 -- Number of spaces tabs count for
vim.o.smartindent = true -- Insert indents automatically

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.o.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
-- vim.o.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

-- For WSL (Windows Subsystem for Linux)
if vim.fn.has 'wsl' == 1 then
    vim.g.clipboard = {
        name = 'WSLClipboard',
        copy = {
            ['+'] = 'clip.exe',
            ['*'] = 'clip.exe',
        },
        paste = {
            -- The -NoProfile and -Command are important.
            -- Use -Raw to prevent potential issues with multi-line pastes being treated as an array.
            ['+'] = 'powershell.exe -NoProfile -Command Get-Clipboard -Raw | Out-File -FilePath - -Encoding UTF8NoBOM',
            ['*'] = 'powershell.exe -NoProfile -Command Get-Clipboard -Raw | Out-File -FilePath - -Encoding UTF8NoBOM',
        },
        cache_enabled = 0,
    }
end

vim.schedule(function()
    vim.o.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = true

-- display how file explorer show the files in neovim
vim.cmd("let g:netrw_liststyle = 3")

-- key to jump to explorer
vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)


-- set to show relative number on the left
vim.o.relativenumber = true

-- do not wrap lines
vim.o.wrap = false

-- enable cursor line
vim.o.cursorline = true

-- turn on termguicolors
vim.o.termguicolors = true
vim.o.background = "dark"
vim.o.signcolumn = "yes"

-- backspace
vim.backspace = "indent,eol,start"

-- enable copy highlights
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})


