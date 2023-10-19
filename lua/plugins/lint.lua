return {
    'mfussenegger/nvim-lint',
    lazy = false,
    dependencies = {
        'williamboman/mason.nvim',
        {
            'rshkarin/mason-nvim-lint',
            opts = {
                ensure_installed = {
                    'actionlint',
                    'jsonlint',
                    'hadolint',
                    'vale',
                    'selene',
                }
            },
        }
    },
    config = function()
        require('lint').linters_by_ft = {
            yaml = { 'actionlint' },
            json = { 'jsonlint' },
            dockerfile = { 'hadolint' },
            mardown = { 'vale' },
            lua = { 'selene' },
        }

        vim.api.nvim_create_autocmd({ "BufWritePost" }, {
            callback = function()
                require("lint").try_lint()
            end,
        })
    end,
}
