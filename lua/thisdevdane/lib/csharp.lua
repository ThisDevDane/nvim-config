local function get_filename(path)
    return path:absolute():sub(string.len(path:parent():expand()) + 2)
end

local _path = require("plenary.path")
local scan = require("plenary.scandir")

local function find_files_with_suffix(start, suffix)
    local traversed = {}
    local result = {}
    local function inner(start, suffix)
        if traversed[start:expand()] == true then
            return
        end
        traversed[start:expand()] = true

        local files = scan.scan_dir(start:expand(), { hidden = true, depth = 1 })
        for _, file in pairs(files) do
            if file:sub(-string.len(suffix)) == suffix then
                table.insert(result, _path:new(file))
            end
        end
        local directories = scan.scan_dir(start:expand(), { hidden = true, depth = 1, only_dirs = true })
        local gitDirSeen = false
        for _, d in pairs(directories) do
            if get_filename(_path:new(d)) == '.git' then
                gitDirSeen = true
            else
                if traversed[d] ~= true then
                    inner(_path:new(d), suffix)
                end
            end
            traversed[d] = true
        end

        if gitDirSeen then
            return
        end

        inner(start:parent(), suffix)
    end

    inner(start, suffix)
    return result
end

local function parse_csproj(csproj_path)
    local xml2lua = require("xml2lua")
    local handler = require("xmlhandler.tree"):new()
    local parser = xml2lua.parser(handler)
    parser:parse(csproj_path:read())
    local groups = handler.root.Project.PropertyGroup

    if #groups < 1 then
        groups = { groups }
    end

    return groups
end

local function find_user_secrets_file()
    local result = {}
    local files = find_files_with_suffix(_path:new(vim.fn.expand("%:p:h")), '.csproj')
    for _, f in ipairs(files) do
        local user_secret_id = ""

        local parsed_csproj = parse_csproj(f)

        for _, p in pairs(parsed_csproj) do
            if p.UserSecretsId ~= nil then
                user_secret_id = p.UserSecretsId
            end
        end

        if user_secret_id ~= "" then
            table.insert(result, {
                project = get_filename(f),
                path = '~/.microsoft/usersecrets/' .. user_secret_id .. '/secrets.json'
            })
        end
    end

    return result
end


local function find_csharp_dll()
    local result = {}
    local files = find_files_with_suffix(_path:new(vim.fn.expand("%:p:h")), '.csproj')

    for _, f in ipairs(files) do
        local assembly_name = ""
        local framework = ""

        local parsed_csproj = parse_csproj(f)

        for _, p in pairs(parsed_csproj) do
            if p.TargetFramework ~= nil then
                framework = p.TargetFramework
            end
            if p.AssemblyName ~= nil then
                assembly_name = p.AssemblyName
            end
        end


        table.insert(result, {
            project = get_filename(f),
            path = f:parent():expand() .. "/bin/Debug/" .. framework .. "/" .. assembly_name .. ".dll"
        })
    end

    return result
end

return {
    find_csharp_dll = find_csharp_dll,
    find_user_secrets_file = find_user_secrets_file
}
