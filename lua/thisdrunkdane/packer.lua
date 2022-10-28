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

    -- Treesitter
    use {
        'nvim-treesitter/nvim-treesitter',
        run = 'TSUpdate',
        config = function()
            require('thisdrunkdane.plugins.treesitter').init()
        end,
    }

    -- Completion
    use {
        'hrsh7th/nvim-cmp',
        requires = {
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-vsnip',
            'hrsh7th/vim-vsnip',
            {
                'onsails/lspkind-nvim',
                config = function()
                    require('lspkind').init()
                end
            }
       },
        config = function()
            require('thisdrunkdane.plugins.nvim-cmp').init()
        end
    }

   -- Language Servers
    use {
        'neovim/nvim-lspconfig',
        requires = {
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' }
        },
        config = function()
            require('thisdrunkdane.plugins.lspconfig').init()
        end
    }

    use {
        'folke/lsp-colors.nvim',
        config = require('lsp-colors').setup()
    }

    use {
        'folke/trouble.nvim',
        requires = 'kyazdani42/nvim-web-devicons',
        config = function()
            require('trouble').setup()
            vim.keymap.set('n', '<leader>xx', '<cmd>TroubleToggle<cr>',
                { silent = true, noremap = true }
            )
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

    use {
        'romgrk/barbar.nvim',
        requires = { 'kyazdani42/nvim-web-devicons' }
    }

    use 'kyazdani42/nvim-web-devicons'

    -- Git Signs
    use {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup()
        end
    }

    -- Utilities
    use 'lukas-reineke/indent-blankline.nvim'
    use {
        'voldikss/vim-floaterm',
        config = function()
            vim.keymap.set('n', '<leader>tt', '<CMD>FloatermNew --autoclose=2 --height=0.9 --width=0.9 zsh<CR>')
        end
    }
    use 'jeffkreeftmeijer/vim-numbertoggle'
    use 'unblevable/quick-scope'

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
