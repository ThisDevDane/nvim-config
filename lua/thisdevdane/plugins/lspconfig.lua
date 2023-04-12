local lua_settings = {
    Lua = {
        runtime = {
            -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
            version = 'LuaJIT',
            -- Setup your lua path
            path = vim.split(package.path, ';'),
        },
        diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = { 'vim' },
        },
        workspace = {
            -- Make the server aware of Neovim runtime files
            library = vim.api.nvim_get_runtime_file("", true)
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = {
            enable = false,
        },
    },
}

local function on_attach(client, bufnr)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration,
        { noremap = true, silent = true, buffer = bufnr, desc = '[LSP] Go to declaration' })
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition,
        { noremap = true, silent = true, buffer = bufnr, desc = '[LSP] Go to definition' })
    vim.keymap.set('n', 'K', vim.lsp.buf.hover,
        { noremap = true, silent = true, buffer = bufnr, desc = '[LSP] Hover signature' })
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation,
        { noremap = true, silent = true, buffer = bufnr, desc = '[LSP] Go to implementation' })
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help,
        { noremap = true, silent = true, buffer = bufnr, desc = '[LSP] Signature help' })
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder,
        { noremap = true, silent = true, buffer = bufnr, desc = '[LSP] Add workspace folder' })
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder,
        { noremap = true, silent = true, buffer = bufnr, desc = '[LSP] Remove workspace folder' })
    vim.keymap.set('n', '<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, { noremap = true, silent = true, buffer = bufnr, desc = '[LSP] List workspace folders' })
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition,
        { noremap = true, silent = true, buffer = bufnr, desc = '[LSP] Go to type definition' })
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename,
        { noremap = true, silent = true, buffer = bufnr, desc = '[LSP] Rename' })
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action,
        { noremap = true, silent = true, buffer = bufnr, desc = '[LSP] List code actions' })
    vim.keymap.set('n', 'gr', vim.lsp.buf.references,
        { noremap = true, silent = true, buffer = bufnr, desc = '[LSP] Go to references' })
    vim.keymap.set('n', '<leader>f', function()
        vim.lsp.buf.format { async = true }
    end, { noremap = true, silent = true, buffer = bufnr, desc = '[LSP] Format' })

    if client.server_capabilities.documentHighlightProvider then
        vim.api.nvim_exec([[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]]   , false)
    end
end

local function set_lsp_keymaps()
    vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float,
        { noremap = true, silent = true, desc = '[LSP] Open diagnostics' })
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev,
        { noremap = true, silent = true, desc = '[LSP] Previous diagnostic' })
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { noremap = true, silent = true, desc = '[LSP] Next diagnostic' })
    vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist,
        { noremap = true, silent = true, desc = '[LSP] Set LoC list' })
end

local function init()
    set_lsp_keymaps()

    require("mason").setup()
    require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "tsserver", "gopls" }
    })

    local lsp = require('lspconfig')
    local capabilities = require('cmp_nvim_lsp').default_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    capabilities.textDocument.completion.completionItem.resolveSupport = {
        properties = {
            'documentation',
            'detail',
            'additionalTextEdits',
        }
    }

    lsp["lua_ls"].setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = lua_settings
    })

    vim.api.nvim_create_autocmd('BufWritePre', {
        pattern = "*.go",
        callback = function()
            vim.lsp.buf.formatting_sync()
        end
    })

    lsp['gopls'].setup({
        capabilities = capabilities,
        on_attach = on_attach,
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

    lsp['tsserver'].setup({
        capabilities = capabilities,
        on_attach = on_attach,
    })
end

return {
    init = init
}
