return {
    'catppuccin/nvim',
    name = "catppuccin",
    priority = 1000,
    opts = {
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
            rainbow_delimiters = true,
            dap = {
                enabled = true,
                enable_ui = true, -- enable nvim-dap-ui
            },
            fidget = true,
            neotest = true,
            illuminate = true,
        }
    },
    init = function()
        vim.cmd('colorscheme catppuccin')
    end
}
