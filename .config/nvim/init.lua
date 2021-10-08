-- Leader
vim.g.mapleader = ' '

-- Encoding
vim.o.enc = 'utf8'
vim.o.fenc = 'utf8'
vim.o.fencs = 'utf8,ms932,cp932,sjis,eucjp-ms,eucjp,latin1'
vim.o.ffs = 'unix,dos,mac'

-- Fixed width
vim.o.ambiwidth = 'single'

-- Don't use meta files
vim.o.backup = false
vim.o.swapfile = false

-- Enabled open other file when the file has not saved
vim.o.hidden = true

-- Reload when opened file has changed
vim.o.autoread = true

-- Show command
vim.o.showcmd = true

-- Don't show Splash
vim.o.shortmess = vim.o.shortmess..'I'

-- Show line number
vim.wo.number = true
vim.wo.relativenumber = true

-- Show current line
vim.wo.cursorline = true

-- One character ahead of the end of the line
vim.o.virtualedit = 'onemore'

-- Don't flash screen
vim.o.visualbell = false

-- Move to corresponding parenthesis
vim.o.showmatch = true
vim.o.matchtime = 1

-- Show to the end
vim.o.display = 'lastline'

-- Always show statuslinle
vim.o.laststatus = 2

-- Indent
vim.o.tabstop = 2
vim.o.softtabstop = -1
vim.o.shiftwidth = 0
vim.o.smarttab = true
vim.o.expandtab = true
vim.o.autoindent = true
vim.o.smartindent = true

-- Clipboard
vim.o.clipboard = 'unnamed,unnamedplus'

-- Always show signcolumn
vim.wo.signcolumn = 'yes'

-- No wrap word
vim.wo.wrap = false

-- Text concealing
vim.wo.conceallevel = 2
vim.wo.concealcursor = 'nc'

-- Split window direction
vim.o.splitbelow = true
vim.o.splitright = true

-- Window move
vim.api.nvim_set_keymap('n', '<A-h>', '<C-w>h', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<A-j>', '<C-w>j', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<A-k>', '<C-w>k', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<A-l>', '<C-w>l', { noremap = true, silent = true })

-- Cursor move for insert / command mode
for _, map in pairs({ 'i', 'c' }) do
  vim.api.nvim_set_keymap(map, '<C-a>', '<Home>', { noremap = true })
  vim.api.nvim_set_keymap(map, '<C-e>', '<End>', { noremap = true })
  vim.api.nvim_set_keymap(map, '<C-b>', '<Left>', { noremap = true })
  vim.api.nvim_set_keymap(map, '<C-f>', '<Right>', { noremap = true })
  vim.api.nvim_set_keymap(map, '<M-b>', '<S-Left>', { noremap = true })
  vim.api.nvim_set_keymap(map, '<M-f>', '<S-Right>', { noremap = true })
  vim.api.nvim_set_keymap(map, '<C-g>', '<Del>', { noremap = true })
end

-- Buffer delete
vim.api.nvim_set_keymap('n', '<Leader>bD', '<Cmd>bd<Cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>baD', ':bufdo :bd<Cr>', { noremap = true, silent = true })

-- Search
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.incsearch = true
vim.o.wrapscan = true
vim.o.hlsearch = true
vim.api.nvim_set_keymap('n', '<Esc><Esc>', '<Cmd>nohlsearch<Cr><Esc>', {})

-- Diff
vim.o.diffopt = 'internal,vertical,filler,algorithm:histogram,indent-heuristic'

-- Nvim clients
vim.g.python_host_prog = '/usr/bin/python2'
vim.g.python3_host_prog = '/usr/bin/python3'
vim.g.ruby_host_prog = '/usr/bin/neovim-ruby-host'
vim.g.node_host_prog = '/usr/bin/neovim-node-host'

-- Colors
vim.o.termguicolors = true

-- Terminal
vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', { noremap = true })

-- Plugins
if not (pcall(require, 'impatient')) then
  print('Load impatient failed')
end
require('plugins')
