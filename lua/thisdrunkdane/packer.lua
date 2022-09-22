local function packer_verify()
    local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

    if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
        vim.fn.system({ 'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.api.nvim_command('packadd packer.nvim')
    end
end

local function packer_startup()
    local packer = require('packer')
    packer.init()
    packer.reset()

    local use = packer.use

    -- Packer
    use 'wbthomason/packer.nvim'

    -- Language Servers
    use {
        'neovim/nvim-lspconfig',
        config = function()
            require('thisdrunkdane.plugins.lspconfig').init()
        end
    }

    -- Theme/UI
    use {
        'folke/tokyonight.nvim',
        config = function()
            require('thisdrunkdane.plugins.tokyonight').init()
        end
    }

    use {
        'folke/lsp-colors.nvim',
        config = require('lsp-colors').setup()
    }

    use {
        'petertriho/nvim-scrollbar',
        config = require('scrollbar').setup()
    }

    use {
        'kyazdani42/nvim-tree.lua',
        requires = {
            'kyazdani42/nvim-web-devicons',
        },
        tag = 'nightly',
        config = require('nvim-tree').setup()
    }

    -- Utilities
    use 'kyazdani42/nvim-web-devicons'
    use 'lukas-reineke/indent-blankline.nvim'
    use 'voldikss/vim-floaterm'
    use 'jeffkreeftmeijer/vim-numbertoggle'

    use {
        'hoob3rt/lualine.nvim',
        config = function()
            require('thisdrunkdane.plugins.lualine').init()
        end
    }

    use {
        'takac/vim-hardtime', -- see http://vimcasts.org/blog/2013/02/habit-breaking-habit-making
        config = function()
            require('thisdrunkdane.plugins.hardtime').init()
        end
    }

    use {
        'numToStr/Comment.nvim',
        config = require('Comment').setup()
    }
end

local function init()
    packer_verify()
    packer_startup()
end

return {
    init = init
}
