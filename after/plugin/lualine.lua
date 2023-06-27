require('lualine').setup {
    options = {
        extensions = { 'fzf', 'quickfix' },
        theme = 'catppuccin'
    },
    sections = {
        lualine_c = {
            require('auto-session.lib').current_session_name,
            'filename'
        },
        lualine_y = {}
    }
}
