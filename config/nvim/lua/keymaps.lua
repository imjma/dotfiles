vim.g.mapleader = ' '

-- better moving keys
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')

-- better indentation
vim.keymap.set('v', '<', '<gv', { noremap = true, silent = true })
vim.keymap.set('v', '>', '>gv', { noremap = true, silent = true })

-- better moving lines
vim.keymap.set('v', 'J', '<cmd>m \'>+1<CR>gv=gv', { noremap = true, silent = true })
vim.keymap.set('v', 'K', '<cmd>m \'<-2<CR>gv=gv', { noremap = true, silent = true })

-- resizing
vim.keymap.set('n', '<leader>-', '<cmd>vertical resize -5<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>=', '<cmd>vertical resize +5<CR>', { noremap = true, silent = true })

-- Split window
vim.keymap.set('n', 'ss', '<cmd>split<Return><C-w>w')
vim.keymap.set('n', 'sv', '<cmd>vsplit<Return><C-w>w')

-- Close window
vim.keymap.set('n', '<leader>q', '<cmd>close<CR>')

-- Telescope
vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>')
vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<cr>')
vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<cr>')
vim.keymap.set('n', '<leader>fh', '<cmd>Telescope help_tags<cr>')
vim.keymap.set('n', '<leader>fa', '<cmd>Telescope diagnostics<cr>')
