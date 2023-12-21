return {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
        lsp = {
            -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                ["cmp.entry.get_documentation"] = true,
            },
        },
        cmdline = {
            view = "cmdline",
        },
        routes = {
            {
                filter = {
                    event = 'msg_show',
                    any = {
                        -- { find = '%d+L, %d+B' },
                        { find = '; after #%d+' },
                        { find = '; before #%d+' },
                        { find = '%d fewer lines' },
                        { find = '%d more lines' },
                    },
                },
                opts = { skip = true },
            },
        },
        -- you can enable a preset for easier configuration
        presets = {
            bottom_search = true,         -- use a classic bottom cmdline for search
            long_message_to_split = true, -- long messages will be sent to a split
            lsp_doc_border = false,       -- add a border to hover docs and signature help
        },
    },
    dependencies = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
    },
    config = function(_, opts)
        require('noice').setup(opts)
        require("telescope").load_extension("noice")
    end
}
