require 'telescope'.setup {
    defaults = {
        file_ignore_patterns = {
            "node_modules/.*",
            "secret.d/.*",
            "%.pem",
            ".git/.*"
        }
    }
}

local ts = require('telescope.builtin')

-- Builtin
vim.keymap.set('n', '<leader>ft', ts.treesitter, { noremap = true, desc = '[TELE] Find tree-sitter' })
vim.keymap.set('n', '<C-p>', function() 
    ts.git_files { show_untracked = true }
end, { noremap = true, desc = '[TELE] Find git files' })
vim.keymap.set('n', '<leader>ff', function()
    ts.find_files { hidden = true }
end, { noremap = true, desc = '[TELE] List files' })
vim.keymap.set('n', '<leader>fl', ts.live_grep, { noremap = true, desc = '[TELE] Live grep' })
vim.keymap.set('n', '<leader>fb', ts.buffers, { noremap = true, desc = '[TELE] Find buffers' })
vim.keymap.set('n', '<leader>fh', ts.help_tags, { noremap = true, desc = '[TELE] Find help tags' })
vim.keymap.set('n', '<leader>fd', ts.diagnostics, { noremap = true, desc = '[TELE] Find diagnostics' })
vim.keymap.set('n', '<leader>fr', ts.registers, { noremap = true, desc = '[TELE] Find registers' })
vim.keymap.set('n', '<leader>fm', ts.keymaps, { noremap = true, desc = '[TELE] Find keymaps' })

-- Language Servers
vim.keymap.set('n', '<leader>lsd', ts.lsp_definitions, { noremap = true, desc = '[TELE] Find lsp definitions' })
vim.keymap.set('n', '<leader>lsr', ts.lsp_references, { noremap = true, desc = '[TELE] Find lsp references' })
vim.keymap.set('n', '<leader>lsi', ts.lsp_implementations,
    { noremap = true, desc = '[TELE] Find lsp implementations' })
vim.keymap.set('n', '<leader>lst', ts.lsp_type_definitions,
    { noremap = true, desc = '[TELE] Find lsp type definitions' })
vim.api.nvim_set_keymap('n', '<Leader>qr',  '<cmd>:lua require("thisdevdane.lib.reload").reload()<CR>', { noremap = true, silent = true })
