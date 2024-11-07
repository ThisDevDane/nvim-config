
function custom_terminal_toggle(cmd)
    local Terminal = require('toggleterm.terminal').Terminal
    local term = Terminal:new({ cmd = cmd, direction = 'float', hidden = true })
    term:toggle()
end

return {
    'akinsho/toggleterm.nvim', 
    version = "*", 
    opts = {},
    keys = {
        { "<leader>lg", function() custom_terminal_toggle('lazygit') end },
        { "<leader>ld", function() custom_terminal_toggle('lazydocker') end },
        { "<leader>k9", function() custom_terminal_toggle('k9s') end },
    },
}

