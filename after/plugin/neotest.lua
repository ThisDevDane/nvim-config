require('neotest').setup {
    adapters = {
        require('neotest-dotnet')({}),
    },
    quickfix = {
        enabled = false
    },
    summary = {
        enabled = true,
        expand_errors = true,
        follow = true,
        mappings = {
            expand = "<space>",
            jumpto = "<cr>",
            run = "r",
            mark = "m",
            run_marked = "R",
            clear_marked = "C",
            output = "o"
        }
    },
    status = {
        enabled = true,
        virtual_text = true,
        signs = true,
    },
    output = {
        open_on_run = false
    },
    icons = {
        running_animated = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
    },
}


local group = vim.api.nvim_create_augroup("NeotestConfig", {})
for _, ft in ipairs({ "output", "attach", "summary" }) do
    vim.api.nvim_create_autocmd("FileType", {
        pattern = "neotest-" .. ft,
        group = group,
        callback = function(opts)
            vim.keymap.set("n", "q", function()
                pcall(vim.api.nviapim_win_close, 0, true)
            end, {
                buffer = opts.buf,
            })
        end,
    })
end
vim.api.nvim_create_autocmd("FileType", {
    pattern = "neotest-output-panel",
    group = group,
    callback = function()
        vim.cmd("norm G")
    end,
})
vim.api.nvim_create_user_command('TestFile', function()
    vim.cmd.write()
    local neo = require("neotest")
    neo.run.run(vim.fn.expand("%:p"))
    neo.summary.open()
end, {})
vim.api.nvim_create_user_command('Test', function()
    vim.cmd.write()
    local neo = require("neotest")
    neo.run.run()
end, {})
vim.api.nvim_create_user_command('TestOut', function()
    local neo = require("neotest")
    neo.output.open({ enter = true, last_run = true })
end, {})
vim.api.nvim_create_user_command('TestSuite', function()
    vim.cmd.write()
    local neo = require("neotest")
    neo.run.run({ suite = true })
    neo.summary.open()
end, {})
