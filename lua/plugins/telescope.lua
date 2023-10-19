return {
    {
        'nvim-telescope/telescope.nvim', 
        branch = '0.1.x',
        lazy = false,
        config = function(opts)
            require('telescope').setup({
                defaults = {
                    file_ignore_patterns = {
                        "node_modules/.*",
                        "secret.d/.*",
                        "%.pem",
                        ".git/.*"
                    }
                },
                extensions = {
                    ['ui-select'] = {
                        require('telescope.themes').get_cursor {
                            layout_config = {
                                height = 12
                            }
                        }
                    }
                }
            })
            require("telescope").load_extension("ui-select")
        end,
        keys = {
            { 
                '<leader>gf', 
                function()
                    require('telescope.builtin').git_files { show_untracked = true }
                end,
                desc = 'Search Git Files'
            },
            { 
                '<leader>sf', 
                function()
                    require('telescope.builtin').find_files { hidden = true }
                end,
                desc = "Search Files"
            },
            { 
                '<C-p>', 
                function()
                    require('telescope.builtin').find_files { hidden = true }
                end,
                desc = "Search Files"
            },
            { '<leader>sg',  function() require('telescope.builtin').live_grep() end, desc = 'Live Grep' },
            { '<leader>sld', function() require('telescope.builtin').lsp_definitions() end, desc = 'Search LSP definitions' },
            { '<leader>slr', function() require('telescope.builtin').lsp_references() end, desc = 'Search LSP references' },
            { '<leader>sli', function() require('telescope.builtin').lsp_implementations() end, desc = 'Search LSP implementations' },
            { '<leader>slt', function() require('telescope.builtin').lsp_type_definitions() end, desc = 'Search LSP type definitions' },
        },
        dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope-ui-select.nvim' }
    }
}
