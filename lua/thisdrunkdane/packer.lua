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
        end
    }

    use {
        'nvim-treesitter/nvim-treesitter-context',
        config = function()
            require('treesitter-context').setup({})
        end
    }

    use {
        'IndianBoy42/tree-sitter-just',
        config = function()
            require('tree-sitter-just').setup({})
        end
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
    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'
    use {
        'neovim/nvim-lspconfig',
        config = function()
            require('thisdrunkdane.plugins.lspconfig').init()
        end
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
        'catppuccin/nvim',
        as = 'catppuccin',
        config = function()
            require('thisdrunkdane.plugins.catppuccin').init()
        end
    }

    use {
        'petertriho/nvim-scrollbar',
        config = function()
            require('scrollbar').setup()
        end
    }

    use {
        'kyazdani42/nvim-tree.lua',
        requires = {
            'kyazdani42/nvim-web-devicons',
        },
        tag = 'nightly',
        config = function()
            require('nvim-tree').setup()
            vim.keymap.set('n', '<leader>n', '<cmd>NvimTreeToggle<cr>', { silent = true, noremap = true })
        end
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
            vim.keymap.set('n', '<leader>tt', '<CMD>FloatermNew --autoclose=2 --height=0.9 --width=0.9 zsh<CR>', { desc = '[FT] New terminal' })
            vim.keymap.set('n', '<leader>lg', '<CMD>FloatermNew --autoclose=2 --height=0.9 --width=0.9 lazygit<CR>', { desc = '[FT] LazyGit' })
            vim.keymap.set('n', '<leader>k9', '<CMD>FloatermNew --autoclose=2 --height=0.9 --width=0.9 k9s<CR>', { desc = '[FT] k9s' })
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
        config = function()
            require('Comment').setup()
        end
    }

    use 'neomake/neomake'

    use {
        "folke/which-key.nvim",
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
            require("which-key").setup {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end
    }

    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            'nvim-lua/plenary.nvim',
        },
        config = function()
            require('thisdrunkdane.plugins.telescope').init()
        end
    }
end

local function init()
    packer_verify()
    packer_startup()
end

return {
    init = init
}
