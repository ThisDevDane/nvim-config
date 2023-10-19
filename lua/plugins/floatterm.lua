return {
    'voldikss/vim-floaterm',
    opts = {},
    keys = {
        { '<leader>tt', '<CMD>FloatermNew --autoclose=2 --height=0.9 --width=0.9 zsh<CR>',                          desc =
        'new terminal' },
        { '<leader>lg', '<CMD>FloatermNew --autoclose=2 --height=0.9 --width=0.9 lazygit<CR>',                      desc =
        'lazygit' },
        { '<leader>ld', '<CMD>FloatermNew --autoclose=2 --height=0.9 --width=0.9 lazydocker<CR>',                   desc =
        'lazydocker' },
        { '<leader>k9', '<CMD>FloatermNew --autoclose=2 --height=0.9 --width=0.9 k9s<CR>',                          desc =
        'k9s' },
        { '<leader>gl', '<CMD>FloatermNew --autoclose=2 --height=0.9 --width=0.5 --position=right glow -p %:p<CR>',
                                                                                                                        desc =
            'glow markdown preview' },
    }
}
