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
        transparent_background = true,
        term_colors = true,
        integrations = {
            cmp = true,
            dap = { enabled = true, enable_ui = true },
            fidget = true,
            gitsigns = true,
            headlines = true,
            illuminate = { enabled = true, lsp = false },
            indent_blankline = { enabled = true, scope_color = 'macchiato', colored_indent_levels = true },
            lsp_trouble = true,
            markdown = true,
            mason = true,
            native_lsp = {
                enabled = true,
                virtual_text = {
                    errors = { "italic" },
                    hints = { "italic" },
                    warnings = { "italic" },
                    information = { "italic" },
                },
                underlines = {
                    errors = { "underline" },
                    hints = { "underline" },
                    warnings = { "underline" },
                    information = { "underline" },
                },
                inlay_hints = {
                    background = true,
                },
            },
            neotest = true,
            noice = true,
            notify = true,
            nvimtree = true,
            rainbow_delimiters = true,
            telescope = true,
            treesitter = true,
            treesitter_context = true,
            ufo = true,
            which_key = true,
        }
    },
    init = function()
        vim.cmd('colorscheme catppuccin')
    end
}
