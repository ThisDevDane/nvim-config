vim.api.nvim_create_user_command('EditUserSecrets', function()
    local file = require('thisdevdane.lib.csharp').find_user_secrets_file()
    vim.cmd.e(file)
end, {})
