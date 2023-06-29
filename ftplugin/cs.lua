local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values

local csharp = require('thisdevdane.lib.csharp')

local user_secrets_prompt = function(opts)
    local dropdown = require("telescope.themes").get_dropdown({})
    opts = opts or dropdown
    pickers.new(opts, {
        prompt_title = "User secrets",
        finder = finders.new_table {
            results = { csharp.find_user_secrets_file() },
            entry_maker = function (entry)
                return {
                    value = entry.path,
                    display = entry.project,
                    ordinal = entry.project
                }
            end
        },
        sorter = conf.generic_sorter(opts),
    }):find()
end

vim.api.nvim_create_user_command('EditUserSecrets', function()
    user_secrets_prompt()
end, {})
