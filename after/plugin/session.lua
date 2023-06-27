vim.o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

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

vim.keymap.set("n", '<leader>fs', require('auto-session.session-lens').search_session, { noremap = true, desc = '[TELE] Find sessions' })
