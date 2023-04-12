local function init()
    require('thisdrunkdane.vim').init()
    require('thisdrunkdane.packer').init()
end

return {
    init = init
}
