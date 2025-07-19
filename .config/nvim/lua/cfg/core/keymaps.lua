vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local keymap = vim.keymap

keymap.set("i", "jk", "<ESC>", { desc = "Exit inset mode with jk" })

keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<leader><left>", "<C-w>h", { desc = "Change to left split" })
keymap.set("n", "<leader><down>", "<C-w>j", { desc = "Change to down split" })
keymap.set("n", "<leader><up>", "<C-w>k", { desc = "Change to up split" })
keymap.set("n", "<leader><right>", "<C-w>l", { desc = "Change to right split" })

-- tab management
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-- move line up/down with Alt key
keymap.set('n', '<A-down>'          , ':m+<CR>=='                                               , bufopts)
keymap.set('i', '<A-down>'          , '<Esc>:m+<CR>==gi'                                        , bufopts)
keymap.set('v', '<A-down>'          , ':m\'>+<CR>gv=gv'                                         , bufopts)
keymap.set('n', '<A-up>'            , ':m-2<CR>=='                                              , bufopts)
keymap.set('i', '<A-up>'            , '<Esc>:m-2<CR>==gi'                                       , bufopts)
keymap.set('v', '<A-up>'            , ':m-2<CR>gv=gv'                                           , bufopts)

-- define tabs to indent
keymap.set('v', '<Tab>'             , '>gv'                                                     , bufopts)
keymap.set('v', '<S-Tab>'           , '<gv'                                                     , bufopts)

-- move coursor by word 
keymap.set('i', '<C-right>'         , '<C-o>:call jump_word_e()<CR>'                            , bufopts)
keymap.set('i', '<C-left>'          , '<C-o>:call jump_word_b()<CR>'                            , bufopts)
keymap.set('n', '<C-right>'         , 'e'                                                       , bufopts) -- https://vi.stackexchange.com/questions/12614/prevent-w-from-jumping-to-next-line#comment21820_12614
keymap.set('n', '<C-left>'          , 'b'                                                       , bufopts)

-- copy/paste/cut
keymap.set('v', '<C-c>'             , 'ygv'                                                     , bufopts) -- https://stackoverflow.com/questions/47842041/
keymap.set('i', '<C-c>'             , '<C-o>yy'                                                 , bufopts)
keymap.set('v', '<C-v>'             , "\"_dgP"                                                  , bufopts)
keymap.set('i', '<C-v>'             , "<C-r>=paste_check()<CR>"                                 , bufopts)
keymap.set('i', '<C-x>'             , '<C-o>dd'                                                 , bufopts) -- i fucked up termux or this messes up with termux
keymap.set('i', '<C-S-d>'           , '<C-o>yy<C-o>p'                                               , bufopts)

keymap.set('v', '<C-x>'             , 'di'                                                      , bufopts)

-- delete line
keymap.set('i', '<C-S-k>'           , '<C-o>"_dd'                                               , bufopts)
keymap.set('i', '<C-S-d>'           , '<C-o>yy<C-o>p', bufopts)

