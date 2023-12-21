local lspzero = {
    'VonHeikemen/lsp-zero.nvim',
    lazy = true,
    branch = "v3.x",
    config = false,
    init = function()
        -- Disable automatic setup, we are doing it manually
        vim.g.lsp_zero_extend_cmp = 0
        vim.g.lsp_zero_extend_lspconfig = 0
    end
}

local nvim_cmp = {
    'hrsh7th/nvim-cmp',
    event = 'BufEnter',
    dependencies = {
        'L3MON4D3/LuaSnip',
        'saadparwaiz1/cmp_luasnip',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-nvim-lsp',
        'onsails/lspkind.nvim'
    },
    config = function()
        vim.diagnostic.config({
            vitual_text = true
        })

        local lsp_zero = require('lsp-zero')
        lsp_zero.extend_cmp()

        local cmp = require('cmp')
        local cmp_action = lsp_zero.cmp_action()

        cmp.setup({
            sources = {
                { name = 'nvim_lsp' },
                { name = 'nvim_lsp_signature_help' },
                { name = 'treesitter' },
                { name = 'buffer',                 keyword_length = 3 },
                { name = 'luasnip',                keyword_length = 2 },
                { name = 'path' },
            },
            preselect = 'item',
            completion = {
                completeopt = 'menu,menuone,noinsert'
            },
            mapping = {
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<CR>'] = cmp.mapping.confirm({ select = true }),
                ['<C-f>'] = cmp_action.luasnip_jump_forward(),
                ['<C-b>'] = cmp_action.luasnip_jump_backward(),
                ['<Tab>'] = cmp_action.luasnip_supertab(),
                ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
            },
            formatting = {
                fields = { 'abbr', 'kind', 'menu' },
                format = require('lspkind').cmp_format({
                    mode = 'symbol',       -- show only symbol annotations
                    maxwidth = 50,         -- prevent the popup from showing more than provided characters
                    ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead
                })
            }
        })
    end
}

local lspconfig = {
    'neovim/nvim-lspconfig',
    cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'williamboman/mason-lspconfig.nvim' },
        { 'Issafalcon/lsp-overloads.nvim' },
    },
    config = function()
        local lsp = require('lsp-zero')
        lsp.extend_lspconfig()

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

                vim.keymap.set('n', 'gs', "<cmd>LspOverloadsSignature<CR>",
                    { buffer = bufnr, desc = '[LSP] Show Signature(s)', noremap = true, silent = true })
            end

            vim.keymap.set('n', '<leader>f', function()
                vim.lsp.buf.format { async = true }
            end, { buffer = bufnr, desc = '[LSP] Format' })
            vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action,
                { buffer = bufnr, desc = '[LSP] List code actions' })
        end)

        lsp.set_sign_icons({
            error = '✘',
            warn = '▲',
            hint = '⚑',
            info = '»'
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

        require('mason-lspconfig').setup({
            ensure_installed = {
                'lua_ls',
                'tsserver',
                'gopls',
                'omnisharp@v1.39.8',
                'svelte',
                'tailwindcss',
                'cssls',
                'rust_analyzer'
            },
            handlers = {
                lsp.default_setup,
                lua_ls = function()
                    -- (Optional) Configure lua language server for neovim
                    local lua_opts = lsp.nvim_lua_ls()
                    require('lspconfig').lua_ls.setup(lua_opts)
                end,
            }
        })
    end
}

return { lspzero, nvim_cmp, lspconfig }
