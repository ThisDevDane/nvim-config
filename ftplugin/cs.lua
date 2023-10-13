local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values

local csharp = require('thisdevdane.lib.csharp')

local user_secrets_prompt = function(opts)
    local dropdown = require("telescope.themes").get_dropdown({})
    opts = opts or dropdown
    pickers.new(opts, {
        prompt_title = "Edit user secrets for project",
        finder = finders.new_table {
            results = csharp.find_user_secrets_file(),
            entry_maker = function(entry)
                return {
                    value = entry.secrets_path,
                    display = entry.name,
                    ordinal = entry.name
                }
            end
        },
        sorter = conf.generic_sorter(opts),
    }):find()
end

vim.api.nvim_create_user_command('EditUserSecrets', function()
    user_secrets_prompt()
end, {})

local ls = require("luasnip")
ls.filetype_extend('cs', { 'csharpdoc' })

local dap = require('dap')
dap.listeners.before.event_initialized['tdd_csharp'] = function()
    vim.cmd('make build')
end

vim.keymap.set('n', '<F5>', function()
    local project_prompt = function(co)
        local actions = require "telescope.actions"
        local action_state = require "telescope.actions.state"
        local dropdown = require("telescope.themes").get_dropdown({})
        pickers.new(dropdown, {
            prompt_title = "What project to debug?",
            finder = finders.new_table {
                results = csharp.find_csharp_dll(),
                entry_maker = function(project)
                    return {
                        value = project,
                        display = project.name,
                        ordinal = project.name
                    }
                end
            },
            sorter = conf.generic_sorter(dropdown),
            attach_mappings = function(prompt_bufnr, _)
                actions.select_default:replace(function()
                    actions.close(prompt_bufnr)
                    local selection = action_state.get_selected_entry()
                    coroutine.resume(co, selection.value)
                end)
                return true
            end,
        }):find()
    end

    local argument_prompt = function(co)
        vim.ui.input({ prompt = "Arguments (leave blank if non-desired):" }, function(value)
            local parts = {}
            for word in value:gmatch("%S+") do table.insert(parts, word) end
            coroutine.resume(co, parts)
        end)
    end

    local thread = coroutine.create(function(co)
        project_prompt(co);
        local project = coroutine.yield()
        argument_prompt(co)
        local arguments = coroutine.yield()

        vim.notify("Starting debug session for " .. project.name .."\ncwd: " .. project.project_root)

        dap.run({
            type = "coreclr",
            name = "launch - netcoredbg",
            request = "launch",
            args = arguments,
            program = project.dll_path,
            cwd = project.project_root
        })
    end)

    coroutine.resume(thread, thread)
end)

