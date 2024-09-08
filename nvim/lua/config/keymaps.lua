-- mods for keybindings
local kmap = vim.keymap

-- mod on terminal mode
kmap.set('t', '<Esc>', '<C-\\><C-n>', { desc = 'Quit terminal' })
kmap.set('', '<leader>tt', ':ToggleTerm <cr>', { desc = '' })

-- mod on normal mode
kmap.set('n', '<leader>bd', ':bd<cr>', { desc = 'Close current buffer' })
kmap.set('n', '<leader>bb', ':b#<cr>', { desc = 'Close current buffer' })
kmap.set('n', '<leader>s', ':%s#', { desc = 'Open replace mode' })

-- mod on all modes
kmap.set('', '<leader>lk', ':WhichKey <cr>', { desc = 'List keybindings' })

-- movement changes
kmap.set('', 's', 'l', { desc = 'Right' })
kmap.set('', 'l', 's', { desc = 'Delete [count] chars and start insert' })
kmap.set('', 'L', 'S', { desc = 'Delete [count] chars and start insert' })
kmap.set('', 'S', 'L', { desc = 'Last line of window' })
kmap.set('', 't', 'j', { desc = 'Down' })
kmap.set('', 'T', 'J', { desc = 'Join [count] lines, 2 lines minimum' })
kmap.set('', 'n', 'k', { desc = 'Up' })
kmap.set('', 'm', 'nzzzv', { desc = 'Search and auto adjust to center' })
kmap.set('', 'M', 'Nzzzv', { desc = 'Search back and auto adjust to center' })

-- save, quit, load opts
kmap.set('', '<leader>rr', ':source %<cr>', { desc = 'Source the current file' })
kmap.set('', '<leader>w<leader>', ':w<cr>', { desc = 'Save' })
kmap.set('', '<leader>wq<leader>', ':wq<cr>', { desc = 'Save and quit' })
kmap.set('', '<leader>qq', ':q<cr>', { desc = 'Quit' })
kmap.set('', '<leader>QQ', ':q!<cr>', { desc = 'Quit without save' })

-- window management
kmap.set('', '<C-h>', '<C-w>h', { desc = 'Swap to left window' })
kmap.set('', '<C-t>', '<C-w>j', { desc = 'Swap to bottom window' })
kmap.set('', '<C-n>', '<C-w>k', { desc = 'Swap to top window' })
kmap.set('', '<C-s>', '<C-w>l', { desc = 'Swap to right window' })
kmap.set('', '<C-w>m', '<C-w>s', { desc = 'Split window' })
kmap.set('', '<C-d>', '<C-w>q', { desc = 'Quit current window' })
