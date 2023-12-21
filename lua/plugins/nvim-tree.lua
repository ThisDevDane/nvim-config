 return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  opts = {
    disable_netrw = true,
    hijack_netrw = true,
    actions = {
        open_file = {
            quit_on_open = true
        }
    },
    git = {
        ignore = false
    }
  },
  -- keys = {
  --   {'<leader>n', '<cmd>NvimTreeToggle<cr>', silent = true, desc = "Open Nvim-Tree"},
  -- },
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
}
