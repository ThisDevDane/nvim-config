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
    'gopls',
    'omnisharp'
    'svelte',
    'tailwindcss',
    'cssls'
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
require('lspconfig').omnisharp.setup({
    enable_import_completion = true,
    on_attach = function(client, bufnr)
        lsp.default_keymaps({ buffer = bufnr })

        vim.keymap.set('n', '<leader>f', function()
            vim.lsp.buf.format { async = true }
        end, { buffer = bufnr, desc = '[LSP] Format' })
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action,
            { buffer = bufnr, desc = '[LSP] List code actions' })

        -- https://github.com/OmniSharp/omnisharp-roslyn/issues/2483#issuecomment-1492605642
        local tokenModifiers = client.server_capabilities.semanticTokensProvider.legend.tokenModifiers
        for i, v in ipairs(tokenModifiers) do
            local tmp = string.gsub(v, ' ', '_')
            tokenModifiers[i] = string.gsub(tmp, '-_', '')
        end
        local tokenTypes = client.server_capabilities.semanticTokensProvider.legend.tokenTypes
        for i, v in ipairs(tokenTypes) do
            local tmp = string.gsub(v, ' ', '_')
            tokenTypes[i] = string.gsub(tmp, '-_', '')
        end
    end
})

lsp.format_on_save({
    format_opts = {
        async = false,
        timeout_ms = 10000,
    },
    servers = {
        ['gopls'] = { 'go' }
    }
})


lsp.setup()

-- vim.api.nvim_create_autocmd('BufWritePre', {
--     pattern = "*.go",
--     callback = function()
--         vim.lsp.buf.format({ async = false })
--     end
-- })


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
