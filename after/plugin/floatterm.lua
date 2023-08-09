vim.keymap.set('n', '<leader>tt', '<CMD>FloatermNew --autoclose=2 --height=0.9 --width=0.9 zsh<CR>',
    { desc = '[FT] New terminal' })
vim.keymap.set('n', '<leader>lg', '<CMD>FloatermNew --autoclose=2 --height=0.9 --width=0.9 lazygit<CR>',
    { desc = '[FT] LazyGit' })
vim.keymap.set('n', '<leader>ld', '<CMD>FloatermNew --autoclose=2 --height=0.9 --width=0.9 lazydocker<CR>',
    { desc = '[FT] LazyDocker' })
vim.keymap.set('n', '<leader>k9', '<CMD>FloatermNew --autoclose=2 --height=0.9 --width=0.9 k9s<CR>',
    { desc = '[FT] k9s' })
vim.keymap.set('n', '<leader>gl', '<CMD>FloatermNew --autoclose=2 --height=0.9 --width=0.5 --position=right glow -p %:p<CR>',
    { desc = '[FT] Glow Mardkown Preview' })
