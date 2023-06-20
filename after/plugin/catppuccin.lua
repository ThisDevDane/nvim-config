require("catppuccin").setup({
    flavour = 'macchiato',
    show_end_of_buffer = true,
    dim_inactive = {
        enabled = true,
        percentage = 0.05
    },
    integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        telescope = true,
        indent_blankline = {
            enabled = true
        },
        mason = true,
        markdown = true,
        treesitter = true,
        lsp_trouble = true,
        which_key = true,
        native_lsp = {
            enabled = true,
        },
        treesitter_context = true,
        ts_rainbow2 = true,
        dap = {
            enabled = true,
            enable_ui = true, -- enable nvim-dap-ui
        },
        fidget = true,
        neotest = true,
        illuminate = true,
    }
})

vim.cmd('colorscheme catppuccin')
