vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.g.mapleader = " "
vim.g.background = "light"

vim.opt.clipboard = "unnamedplus"

vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>')
vim.wo.number = true
vim.wo.relativenumber = true

-- Navigate vim panes better
vim.keymap.set('n', '<c-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<c-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<c-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<c-l>', ':wincmd l<CR>')

-- Delete to the black hole register by default
-- when I delete, I dont want this to be saved.
vim.keymap.set('n', 'd', '"_d')
vim.keymap.set('n', 'dd', '"_dd')
vim.keymap.set('v', 'd', '"_d')

-- Maintain visual mode after indenting
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- Mojo
vim.filetype.add({
    extension = {
        mojo = "mojo",
    },
})
