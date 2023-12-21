return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
    },
    opts = {
        source_selector = {
            winbar = true,
        },
        filesystem = {
            filtered_items = {
                hide_dotfiles = false,
                hide_gitignored = false,
                hide_by_name = {
                    "node_modules"
                },
                never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
                    ".DS_Store",
                    "thumbs.db"
                },
            },
        }
    },
    keys = {
        { '<leader>n', '<cmd>Neotree toggle<cr>', silent = true, desc = "Open Nvim-Tree" },
    },
}
