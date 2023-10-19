return {
    {
        'mfussenegger/nvim-dap',
        dependencies = {
            'rcarriga/nvim-dap-ui',
            config = function()
                local dap = require('dap')
                local ui = require("dapui")
                ui.setup()

                dap.listeners.after.event_initialized["dapui_config"] = function()
                    ui.open()
                end
            end,
            keys = {
                { '<leader>dt', function() require('dapui').toggle({}) end,         desc = 'Toggle DAP UI' },
                { '<leader>dh', function() require('dap.ui.widgets').hover() end,   desc = 'DAP UI Hover' },
                { '<leader>dp', function() require('dap.ui.widgets').preview() end, desc = 'DAP UI Preview' },
                {
                    '<leader>df',
                    function()
                        local widgets = require('dap.ui.widgets')
                        widgets.centered_float(widgets.frames)
                    end,
                    desc = 'DAP UI Preview'
                },
                {
                    '<leader>ds',
                    function()
                        local widgets = require('dap.ui.widgets')
                        widgets.centered_float(widgets.scopes)
                    end,
                    desc = 'DAP UI Preview'
                },
            },
            {
                'theHamsta/nvim-dap-virtual-text',
                opts = {},
            }
        },
        config = function()
            vim.api.nvim_set_hl(0, 'DapBreakpointRejected', { ctermbg = 0, fg = '#787878' })
            vim.api.nvim_set_hl(0, 'DapStopped', { ctermbg = 0, fg = '#98c379' })

            vim.fn.sign_define('DapBreakpoint', { text = '●', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
            vim.fn.sign_define('DapBreakpointCondition',
                { text = '▲', texthl = 'DapBreakpointCondition', linehl = '', numhl = '' })
            vim.fn.sign_define('DapBreakpointRejected',
                { text = '◐', texthl = 'DapBreakpointRejected', linehl = '', numhl = '' })
            vim.fn.sign_define('DapLogPoint', { text = '◯', texthl = 'DapLogPoint', linehl = '', numhl = '' })
            vim.fn.sign_define('DapStopped', { text = '▶', texthl = 'DapStopped', linehl = '', numhl = '' })
        end,
        keys = {
            {
                '<leader>db',
                function() require('dap').toggle_breakpoint() end,
                desc =
                'Toggle breakpoint'
            },
            {
                '<leader>dB',
                function() require('dap').set_breakpoint() end,
                desc =
                'Set breakpoint'
            },
            {
                '<leader>dB',
                function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end,
                desc =
                'Set Log point'
            },
            { '<F5>',       function() require('dap').continue() end },
            { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
            { "<leader>do", function() require("dap").step_out() end,  desc = "Step Out" },
            { "<leader>dO", function() require("dap").step_over() end, desc = "Step Over" },
        },
    },
    require('plugins.dap.go'),
    require('plugins.dap.csharp'),
}
