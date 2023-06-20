vim.g.mapleader = ' '
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.guicursor = 'n:block,v-sm:block-blinkwait300-blinkon200-blinkoff150,c-i-ci-ve:ver25,r-cr-o:hor20'
vim.opt.cursorline = true

vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.secure = true
vim.opt.errorbells = false

vim.opt.scrolloff = 3

vim.opt.termguicolors = true
vim.opt.encoding = 'utf8'
vim.opt.splitright = true
vim.opt.updatetime = 50

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.mouse = 'a'
vim.opt.makeprg = 'just'

vim.opt.signcolumn = "yes"

vim.opt.cmdheight = 0

local augroup = vim.api.nvim_create_augroup('user_cmds', { clear = true })

vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'help', 'man' },
    group = augroup,
    desc = 'Use q to close the window',
    command = 'nnoremap <buffer> q <cmd>quit<cr>'
})

vim.api.nvim_create_autocmd('TextYankPost', {
    group = augroup,
    desc = 'Highlight on yank',
    callback = function()
        vim.highlight.on_yank({ higroup = 'Visual', timeout = 200 })
    end
})

-- vim.keymap.set('n', '<leader>h', '<CMD>wincmd h<CR>')
-- vim.keymap.set('n', '<leader>j', '<CMD>wincmd j<CR>')
-- vim.keymap.set('n', '<leader>k', '<CMD>wincmd k<CR>')
-- vim.keymap.set('n', '<leader>l', '<CMD>wincmd l<CR>')

-- All keybindings below were "stolen" from ThePrimeagen
vim.keymap.set('n', '<C-d>', '<C-d>zz', { noremap = true }) -- Half page down and center
vim.keymap.set('n', '<C-u>', '<C-u>zz', { noremap = true }) -- Half page up and center

vim.keymap.set('n', 'n', 'nzzzv', { noremap = true }) -- Next result, center and unfold
vim.keymap.set('n', 'N', 'Nzzzv', { noremap = true }) -- Previous result, center and unfold

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv") -- Move marked lines up
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv") -- Move marked lines down

-- Paste without losing register
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Yank to system clipboard
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Delete into the void register
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

-- Start replace word under cursor
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
