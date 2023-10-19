local ts = {
    "nvim-treesitter/nvim-treesitter",
    build = function()
        require("nvim-treesitter.install").update({ with_sync = true })()
    end,
    opts = {
        ensure_installed = {
            'bash',
            'css',
            'dockerfile',
            'go',
            'gomod',
            'graphql',
            'html',
            'javascript',
            'jsdoc',
            'json',
            'lua',
            'tsx',
            'typescript',
            'yaml',
            'markdown',
            'gitignore',
            'glsl',
            'hlsl',

        },
        auto_install = true,
        sync_install = false,
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false
        },
        indent = {
            enable = true
        }
    },
    config = function(_, opts)
        require("nvim-treesitter.configs").setup(opts)
    end
}

return {
    ts,
    {
        'nvim-treesitter/nvim-treesitter-context',
        lazy = false,
    },
    {
        'IndianBoy42/tree-sitter-just',
        lazy = false
    },
    {
        "windwp/nvim-ts-autotag",
        event = "InsertEnter",
        opts = {},
    },
}
