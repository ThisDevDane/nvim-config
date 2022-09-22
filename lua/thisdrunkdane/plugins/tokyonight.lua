local function init()
    require("tokyonight").setup({
        sidebars = { "help", "qf", "vista_kind", "terminal", "packer" },
        lualine_bold = true,
        dim_inactive = true,
        hide_inactive_statusline = true,
    })

    vim.cmd('colorscheme tokyonight')
end

return {
    init = init
}
