local home = os.getenv("HOME")

-- if home ~= nil then
--     local path = table.concat({
--         '~/.luarocks/share/lua/5.1/?.lua',
--         '~/.luarocks/share/lua/5.1/?/init.lua'
--     }, ";")
--
--     local cpath = table.concat({
--         '~/.luarocks/lib/lua/5.1/?.so'
--     }, ";")
--     package.path = package.path .. ';' .. path:gsub("~", home)
--     package.cpath = package.cpath .. ';'.. cpath:gsub("~", home)
-- end
require("thisdevdane")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup("plugins")
