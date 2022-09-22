local function init()
    require('thisdrunkdane.packer').init()
    require('thisdrunkdane.vim').init()
end

return {
    init = init
}
