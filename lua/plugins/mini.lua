return {
    'echasnovski/mini.nvim',
    version = '*',
    config = function()
        require('mini.surround').setup()
        require('mini.pairs').setup()
        require('mini.comment').setup()
        require('mini.hipatterns').setup()
        require('mini.tabline').setup()
    end
}
