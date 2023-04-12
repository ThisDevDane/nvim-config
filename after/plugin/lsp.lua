local lsp = require('lsp-zero').preset('recommended')

lsp.on_attach(function(client, bufnr)
    lsp.default_keymaps({ buffer = bufnr })

    vim.keymap.set('n', '<leader>f', function()
        vim.lsp.buf.format { async = true }
    end, { buffer = bufnr, desc = '[LSP] Format' })
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action,
        { buffer = bufnr, desc = '[LSP] List code actions' })


end)

lsp.ensure_installed({
    'lua_ls',
    'tsserver',
    'gopls'
})

lsp.set_sign_icons({
    error = '✘',
    warn = '▲',
    hint = '⚑',
    info = '»'
})

-- (Optional) Configure lua language server for neovim
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
require('lspconfig').gopls.setup({
    settings = {
        gopls = {
            experimentalPostfixCompletions = true,
            analyses = {
                unusedparams = true,
                shadow = true,
            },
            staticcheck = true,
        }
    }
})

lsp.setup()

vim.api.nvim_create_autocmd('BufWritePre', {
    pattern = "*.go",
    callback = function()
        vim.lsp.buf.formatting_sync()
    end
})


vim.diagnostic.config({
    vitual_text = true
})

local cmp = require('cmp')

cmp.setup({
    sources = {
        { name = 'path' },
        { name = 'treesitter' },
        { name = 'nvim_lsp' },
        { name = 'buffer', keyword_length = 3 },
        { name = 'luasnip', keyword_length = 2 },
    },
    preselect = 'item',
    completion = {
        completeopt = 'menu,menuone,noinsert'
    },
    mapping = {
        ['<CR>'] = cmp.mapping.confirm({ select = true })
    }
})
