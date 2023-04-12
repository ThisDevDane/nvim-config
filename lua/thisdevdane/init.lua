local function init()
    require('thisdevdane.vim').init()
    require('thisdevdane.packer').init()
end

return {
    init = init
}
