return {
    'rmagatti/auto-session',
    lazy = false,
    config = function()
        require("auto-session").setup {
            cwd_change_handling = {
                post_cwd_changed_hook = function()
                    require("lualine").refresh()
                end,
            },

            session_lens = {
                load_on_setup = true,
                theme_conf = { border = true },
            }
        }

        vim.keymap.set("n", '<leader>ss', require('auto-session.session-lens').search_session, { noremap = true, desc = 'Search sessions' })
    end
}
