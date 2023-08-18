require('nvim-treesitter.configs').setup {
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
}

