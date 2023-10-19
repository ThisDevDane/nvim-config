return {
    dir = vim.fn.stdpath("config") .. 'lua/plugins/dap/csharp.lua',
    name = 'dap-csharp',
    ft = 'cs',
    dependencies = { 'mfussenegger/nvim-dap' },
    config = function()
        local dap = require('dap')
        dap.adapters.coreclr = {
            type = 'executable',
            command = 'netcoredbg',
            args = { '--interpreter=vscode' }
        }
    end
}
