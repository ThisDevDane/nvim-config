require('nvim-tree').setup({
    disable_netrw = true,
    hijack_netrw = true,
    actions = {
        open_file = {
            quit_on_open = true
        }
    },
    git = {
        ignore = false
    }
})

vim.keymap.set('n', '<leader>n', '<cmd>NvimTreeToggle<cr>', { silent = true, noremap = true })
