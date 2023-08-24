local dap = require('dap')
local csharp = require('thisdevdane.lib.csharp')

dap.adapters.coreclr = {
    type = 'executable',
    command = 'netcoredbg',
    args = { '--interpreter=vscode' }
}
dap.configurations.cs = {
    {
        type = "coreclr",
        name = "launch - netcoredbg",
        request = "launch",
        args = function()
            return coroutine.create(function(dap_run_co)
                vim.ui.input({ prompt = "Arguments (leave blank if non-desired):" }, function(value)
                    local parts = {}
                    for word in value:gmatch("%S+") do table.insert(parts, word) end
                    coroutine.resume(dap_run_co, parts)
                end)
            end)
        end,
        program = function()
            return coroutine.create(function(dap_run_co)
                local pickers = require "telescope.pickers"
                local finders = require "telescope.finders"
                local conf = require("telescope.config").values
                local actions = require "telescope.actions"
                local action_state = require "telescope.actions.state"
                local dropdown = require("telescope.themes").get_dropdown({})
                pickers.new(dropdown, {
                    prompt_title = "What project to debug?",
                    finder = finders.new_table {
                        results = csharp.find_csharp_dll(),
                        entry_maker = function(entry)
                            return {
                                value = entry.path,
                                display = entry.project,
                                ordinal = entry.project
                            }
                        end
                    },
                    sorter = conf.generic_sorter(dropdown),
                    attach_mappings = function(prompt_bufnr, _)
                        actions.select_default:replace(function()
                            actions.close(prompt_bufnr)
                            local selection = action_state.get_selected_entry()
                            coroutine.resume(dap_run_co, selection.value)
                        end)
                        return true
                    end,
                }):find()
            end)
        end,
    },
}



require('dap-go').setup()
local ui = require("dapui")
ui.setup()

dap.listeners.after.event_initialized["dapui_config"] = function()
    ui.open()
end
-- dap.listeners.before.event_terminated["dapui_config"] = function()
--     ui.close()
-- end
-- dap.listeners.before.event_exited["dapui_config"] = function()
--     ui.close()
-- end

-- Symbols
vim.api.nvim_set_hl(0, 'DapBreakpointRejected', { ctermbg = 0, fg = '#787878' })
vim.api.nvim_set_hl(0, 'DapStopped', { ctermbg = 0, fg = '#98c379' })

vim.fn.sign_define('DapBreakpoint', { text = '●', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
vim.fn.sign_define('DapBreakpointCondition', { text = '▲', texthl = 'DapBreakpointCondition', linehl = '', numhl = '' })
vim.fn.sign_define('DapBreakpointRejected', { text = '◐', texthl = 'DapBreakpointRejected', linehl = '', numhl = '' })
vim.fn.sign_define('DapLogPoint', { text = '◯', texthl = 'DapLogPoint', linehl = '', numhl = '' })
vim.fn.sign_define('DapStopped', { text = '▶', texthl = 'DapStopped', linehl = '', numhl = '' })


-- Keymaps
vim.keymap.set('n', '<leader>dt', ui.toggle)
vim.keymap.set('n', '<Leader>db', dap.toggle_breakpoint)
-- Suggested
vim.keymap.set('n', '<F5>', function() require('dap').continue() end)
vim.keymap.set('n', '<F10>', function() require('dap').step_over() end)
vim.keymap.set('n', '<F11>', function() require('dap').step_into() end)
vim.keymap.set('n', '<F12>', function() require('dap').step_out() end)
vim.keymap.set('n', '<Leader>dB', function() require('dap').set_breakpoint() end)
vim.keymap.set('n', '<Leader>dlp',
    function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)
vim.keymap.set({ 'n', 'v' }, '<Leader>dh', function()
    require('dap.ui.widgets').hover()
end)
vim.keymap.set({ 'n', 'v' }, '<Leader>dp', function()
    require('dap.ui.widgets').preview()
end)
vim.keymap.set('n', '<Leader>df', function()
    local widgets = require('dap.ui.widgets')
    widgets.centered_float(widgets.frames)
end)
vim.keymap.set('n', '<Leader>ds', function()
    local widgets = require('dap.ui.widgets')
    widgets.centered_float(widgets.scopes)
end)
