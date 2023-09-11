local home = os.getenv("HOME")

if home ~= nil then
    local path = table.concat({
        '~/.luarocks/share/lua/5.1/?.lua',
        '~/.luarocks/share/lua/5.1/?/init.lua'
    }, ";")

    local cpath = table.concat({
        '~/.luarocks/lib/lua/5.1/?.so'
    }, ";")
    package.path = package.path .. ';' .. path:gsub("~", home)
    package.cpath = package.cpath .. ';'.. cpath:gsub("~", home)
end

require('thisdevdane')

