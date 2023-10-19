return {
    'hoob3rt/lualine.nvim',
    lazy = false,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        local opts = {
            options = {
                extensions = { 'fzf', 'quickfix' },
                theme = 'catppuccin',
            },
            sections = {
                lualine_c = {
                    require('auto-session.lib').current_session_name,
                    'filename'
                },
                lualine_y = {
                    {
                        require("lazy.status").updates,
                        cond = require("lazy.status").has_updates,
                        color = { fg = "#ff9e64" },
                    },
                },
            },
        }
        require('lualine').setup(opts)
    end
}
