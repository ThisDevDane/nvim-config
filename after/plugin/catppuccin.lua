require("catppuccin").setup({
    flavour = 'macchiato',
    show_end_of_buffer = true,
    integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        telescope = true,
        indent_blankline = {
            enabled = true
        },
        mason = true,
        treesitter = true,
        lsp_trouble = true,
        which_key = true,
        native_lsp = {
            enabled = true,
        },
        barbar = true,
    }
})

vim.cmd('colorscheme catppuccin')
