require('plugins')
require('keymaps')

vim.opt.backspace = { 'start', 'eol', 'indent' }
vim.opt.backup = false
vim.opt.clipboard = 'unnamedplus'
vim.opt.cmdheight = 1
vim.opt.completeopt = 'menuone,noselect,noinsert'
vim.opt.cursorline = true
vim.opt.errorbells = false
vim.opt.expandtab = true
vim.opt.foldmethod = 'indent'
vim.opt.foldenable = false
vim.opt.hidden = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.inccommand = 'split'
vim.opt.joinspaces = false
vim.opt.laststatus = 2
vim.opt.list = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 10
vim.opt.shiftwidth = 2
vim.opt.shortmess:append('c')
vim.opt.showbreak = '↪'
vim.opt.signcolumn = 'yes'
vim.opt.smartcase = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.tabstop = 2
vim.opt.undofile = true
vim.opt.updatetime = 50
vim.opt.wrap = false

-- Turn off paste mode when leaving insert
vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = '*',
  command = "set nopaste"
})

vim.opt.background = "dark" -- or "light" for light mode
vim.g['gruvbox_material_background'] = 'medium'
vim.cmd([[colorscheme gruvbox-material]])
