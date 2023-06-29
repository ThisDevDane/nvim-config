P = function(v)
    print(vim.inspect(v))
    return v
end

if pcall(require, "plenary") then
    RELOAD = require("plenary.reload").reload_module

    Reload_Module = function(name)
        RELOAD(name)
        return require(name)
    end
end

local M = {}

local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

function M.reload()
    -- Telescope will give us something like ju/colors.lua,
    -- so this function convert the selected entry to
    -- the module name: ju.colors
    local function get_module_name(s)
        local module_name;

        module_name = s:gsub("%.lua", "")
        module_name = module_name:gsub("%/", ".")
        module_name = module_name:gsub("%.init", "")

        return module_name
    end

    local prompt_title = "~ neovim modules ~"

    -- sets the path to the lua folder
    local path = "~/.config/nvim/lua"

    local opts = {
        prompt_title = prompt_title,
        cwd = path,

        attach_mappings = function(prompt_bufnr, _)
            actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local entry = action_state.get_selected_entry()
                local name = get_module_name(entry.value)

                -- call the helper method to reload the module
                -- and give some feedback
                Reload_Module(name)
                P(name .. " RELOADED!!!")
            end)
            return true
        end
    }
    require('telescope.builtin').find_files(opts)
end

return M
