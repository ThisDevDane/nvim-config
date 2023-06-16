local dap = require('dap')

dap.adapters.coreclr = {
    type = 'executable',
    command = 'netcoredbg',
    args = { '--interpreter=vscode' }
}

local function find_csharp_dll()
    local expanded_path = vim.fn.expand("%:p:h")
    local plenary_path = require("plenary.path")
    local current_path = plenary_path:new(expanded_path)
    local scan = require("plenary.scandir")

    local idx = 0
    local function look_for_csproj(path, recursion_depth)
        if recursion_depth > 6 then
            print("Reached maximum allowed recusion to find .csproj")
            return plenary_path:new(), false
        end
        local found_csproj = false

        local files = scan.scan_dir(path:expand(), { hidden = false, depth = 1 })
        for _, file in pairs(files) do
            if file:sub(-string.len(".csproj")) == ".csproj" then
                found_csproj = true
                return plenary_path:new(file), true
            end
        end

        if found_csproj == false then
            recursion_depth = recursion_depth + 1
            path = path:parent()
            return look_for_csproj(path, recursion_depth)
        end
    end
    local csproj_path, found = look_for_csproj(current_path, idx)

    if found then
        local assemlby_name = ""
        local framework = ""

        local xml2lua = require("xml2lua")
        local handler = require("xmlhandler.tree"):new()
        local parser = xml2lua.parser(handler)
        parser:parse(csproj_path:read())
        local groups = handler.root.Project.PropertyGroup

        if #groups < 1 then
            groups = {groups, {}}
        end

        for _, p in pairs(groups) do
            if p.TargetFramework ~= nil then
                framework = p.TargetFramework
            end
            if p.AssemblyName ~= nil then
                assemlby_name = p.AssemblyName
            end
        end

        return csproj_path:parent():expand().."/bin/Debug/"..framework.."/"..assemlby_name..".dll"
    end

    return ""
end

dap.configurations.cs = {
    {
        type = "coreclr",
        name = "launch - netcoredbg",
        request = "launch",
        program = function()
            local input = ''

            vim.ui.input({ prompt = 'Path to dll: ', default = find_csharp_dll(), completion = 'file' },
                function(i)
                    input = i
                end)
            return input
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
