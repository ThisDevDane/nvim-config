local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()
vim.cmd [[packadd packer.nvim]]

return require('packer').startup({
    function(use) -- Packer
        use 'wbthomason/packer.nvim'

        -- Treesitter
        use {
            'nvim-treesitter/nvim-treesitter',
            run = 'TSUpdate',
        }
        use 'nvim-treesitter/nvim-treesitter-context'
        use {
            'IndianBoy42/tree-sitter-just',
            config = function()
                require('tree-sitter-just').setup({})
            end
        }

        use { 'L3MON4D3/LuaSnip',
            requires = { 'rafamadriz/friendly-snippets' }
        }

        -- Session
        use 'rmagatti/auto-session'

        -- Language Servers
        use {
            'VonHeikemen/lsp-zero.nvim',
            branch = 'v2.x',
            requires = {
                -- LSP Support
                { 'neovim/nvim-lspconfig' }, -- Required
                {                            -- Optional
                    'williamboman/mason.nvim',
                    run = ":MasonUpdate"
                },
                { 'williamboman/mason-lspconfig.nvim' }, -- Optional

                -- Autocompletion
                { 'hrsh7th/nvim-cmp' },     -- Required
                { 'hrsh7th/cmp-buffer' },   -- Required
                { 'hrsh7th/cmp-path' },     -- Required
                { 'hrsh7th/cmp-nvim-lsp' }, -- Required
                { 'L3MON4D3/LuaSnip' },     -- Required
                { 'saadparwaiz1/cmp_luasnip' },
                { 'onsails/lspkind.nvim' },
            }
        }

        use {
            'folke/trouble.nvim',
            requires = 'kyazdani42/nvim-web-devicons',
        }

        -- DAP
        use 'mfussenegger/nvim-dap'
        use 'rcarriga/nvim-dap-ui'
        use 'leoluz/nvim-dap-go'

        -- Theme/UI
        use {
            'rcarriga/nvim-notify',
            config = function()
                require("notify").setup()
                vim.notify = require("notify")
            end
        }
        use {
            'catppuccin/nvim',
            as = 'catppuccin',
        }

        use 'kyazdani42/nvim-web-devicons'
        use 'kyazdani42/nvim-tree.lua'
        use 'hoob3rt/lualine.nvim'
        use {
            'lewis6991/gitsigns.nvim',
            config = function()
                require('gitsigns').setup()
            end
        }
        use {
            'j-hui/fidget.nvim',
            branch = 'legacy',
        }

        -- Utilities
        use_rocks "xml2lua"
        use { "nvim-lua/plenary.nvim" }
        use {
            "nvim-neotest/neotest",
            requires = {
                { "nvim-lua/plenary.nvim" },
                { "Issafalcon/neotest-dotnet" },
            }
        }
        use {
            "aserowy/tmux.nvim",
            config = function()
                require("tmux").setup()
            end
        }
        use 'lukas-reineke/indent-blankline.nvim'
        use 'voldikss/vim-floaterm'
        use 'jeffkreeftmeijer/vim-numbertoggle'
        use 'unblevable/quick-scope'
        use {
            'takac/vim-hardtime', -- see http://vimcasts.org/blog/2013/02/habit-breaking-habit-making
            config = function()
                vim.g.hardtime_default_on = 0
                vim.g.hardtime_showmsg = 1
            end
        }
        use {
            'numToStr/Comment.nvim',
            config = function()
                require('Comment').setup()
            end
        }

        use {
            'folke/todo-comments.nvim',
            requires = { 'nvim-lua/plenary.nvim' },
            config = function()
                require('todo-comments').setup({})
            end
        }

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
        }
        use 'nvim-telescope/telescope-ui-select.nvim'
        use 'RRethy/vim-illuminate'

        use {
            'kevinhwang91/nvim-ufo',
            requires = {
                'kevinhwang91/promise-async'
            },
        }
        use {
            'andrewferrier/wrapping.nvim',
            config = function ()
                require('wrapping').setup()
            end
        }
        use {'psliwka/vim-dirtytalk', run = ':DirtytalkUpdate'}
        use 'Issafalcon/lsp-overloads.nvim'
        use {
            'echasnovski/mini.nvim',
            config = function ()
                require('mini.surround').setup()
                require('mini.pairs').setup()
            end
        }
        if packer_bootstrap then
            require('packer').sync()
        end
    end,
    config = {
        luarocks = {
            python_cmd = 'python3'
        }
    }
})
