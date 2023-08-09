local lsp = require('lsp-zero').preset('recommended')

lsp.on_attach(function(client, bufnr)
    lsp.default_keymaps({ buffer = bufnr })

    if client.server_capabilities.signatureHelpProvider then
        require('lsp-overloads').setup(client, {
            ui = {
                border = 'rounded'
            },
            keymaps = {
                next_signature = '<C-n>',
                previous_signature = '<C-p>',
                close_signature = '<C-q>'
            }
        })

        vim.keymap.set('n', 'gs', "<cmd>LspOverloadsSignature<CR>", { buffer = bufnr, desc = '[LSP] Show Signature(s)', noremap = true, silent = true })
    end

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
    'omnisharp',
    'svelte',
    'tailwindcss',
    'cssls',
    'rust_analyzer'
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
    enable_roslyn_analyzers = true,
    organize_imports_on_format = true,
    on_attach = function(client, _)
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
        ['gopls'] = { 'go' },
        ['rust_analyzer'] = { 'rust' }
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
local cmp_action = require('lsp-zero').cmp_action()
require('luasnip.loaders.from_vscode').lazy_load()

cmp.setup({
    sources = {
        { name = 'nvim_lsp' },
        { name = 'nvim_lsp_signature_help' },
        { name = 'treesitter' },
        { name = 'buffer',    keyword_length = 3 },
        { name = 'luasnip',   keyword_length = 2 },
        { name = 'path' },
    },
    preselect = 'item',
    completion = {
        completeopt = 'menu,menuone,noinsert'
    },
    mapping = {
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<C-f>'] = cmp_action.luasnip_jump_forward(),
        ['<C-b>'] = cmp_action.luasnip_jump_backward(),
    }
})

require('trouble').setup({})
vim.keymap.set('n', '<leader>xx', '<cmd>TroubleToggle<cr>',
    { silent = true, noremap = true }
)
vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>",
  {silent = true, noremap = true}
)
vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>",
  {silent = true, noremap = true}
)

require "fidget".setup({})
