local function set_vim_g()
    vim.g.mapleader = ' '
end

local function set_vim_opt()
    vim.opt.shiftwidth = 4
    vim.opt.softtabstop = 4
    vim.opt.tabstop = 4
    vim.opt.expandtab = true

    vim.opt.secure = true
    vim.opt.errorbells = false

    vim.opt.scrolloff = 3

    vim.opt.termguicolors = true
    vim.opt.encoding = 'utf8'
    vim.opt.splitright = true
    vim.opt.updatetime = 300

    vim.opt.number = true
    vim.opt.relativenumber = true
    vim.opt.wrap = false

    vim.opt.hlsearch = false

    vim.opt.mouse = 'a'
end

local function create_user_autocommands()
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
end

local function set_vim_keymap()
    -- vim.keymap.set('n', '<leader>h', '<CMD>wincmd h<CR>')
    -- vim.keymap.set('n', '<leader>j', '<CMD>wincmd j<CR>')
    -- vim.keymap.set('n', '<leader>k', '<CMD>wincmd k<CR>')
    -- vim.keymap.set('n', '<leader>l', '<CMD>wincmd l<CR>')
end

local function init()
    set_vim_g()
    set_vim_opt()
    set_vim_keymap()
    create_user_autocommands()
end

return {
    init = init
}
