local CachedDBs = {}

local function NewDB(dbName, defaultData)
    if dbName == nil then
        error("DB name cannot be nil")
        return
    end

    if defaultData == nil then
        defaultData = {}
    end

    local DBObj = {}
    local DBFile = LoadResourceFile(resName, "./db/" .. dbName .. ".json")

    if DBFile then
        CachedDBs[dbName] = json.decode(DBFile)
    else
        CachedDBs[dbName] = {}
        SaveResourceFile(resName, "./db/" .. dbName .. ".json", json.encode(defaultData), -1)
    end

    -- Normal operations
    function DBObj:AddKey(key, value)
        if CachedDBs[dbName][key] == nil then
            CachedDBs[dbName][key] = value
        else
            error("Key already exists")
        end

        return CachedDBs[dbName]
    end

    function DBObj:UpdateKey(key, newValue)
        if key == nil or type(key) ~= "string" then
            error("Invalid type of key or missing key")
        else
            if newValue then
                CachedDBs[dbName][key] = newValue
            else
                error("Missing new value")
            end
        end

        return CachedDBs[dbName]
    end

    function DBObj:RemoveKey(key)
        if key == nil or type(key) ~= "string" then
            error("Invalid type of key or missing key")
        else
            CachedDBs[dbName][key] = nil
        end

        return CachedDBs[dbName]
    end

    -- Misc operations
    function DBObj:GetData()
        return CachedDBs[dbName]
    end

    function DBObj:UpdateRawData(newValue)
        if newValue then
            if type(newValue) == "table" then
                CachedDBs[dbName] = newValue
            elseif type(newValue) == "string" then
                CachedDBs[dbName] = json.decode(newValue)
            else
                error("Invalid type for new value")
            end
        else
            error("Misisng new value")
        end

        return CachedDBs[dbName]
    end

    -- Save & Wipe
    function DBObj:ForceSave()
        SaveResourceFile(resName, "./db/" .. dbName .. ".json", json.encode(CachedDBs[dbName]), -1)
    end

    function DBObj:Wipe()
        SaveResourceFile(resName, "./db/" .. dbName .. ".json", json.encode(defaultData), -1)
    end

    -- Table operations
    function DBObj:TableInsert(key, value)
        if CachedDBs[dbName][key] then
            if type(CachedDBs[dbName][key]) == "table" then
                table.insert(CachedDBs[dbName][key], value)
            else
                error("Key is not a table")
            end
        else
            error("Key does not exist")
        end

        return CachedDBs[dbName]
    end

    function DBObj:TableRemove(key, index)
        if CachedDBs[dbName][key] then
            if type(CachedDBs[dbName][key]) == "table" then
                if CachedDBs[dbName][key][index] then
                    CachedDBs[dbName][key][index] = nil
                else
                    error("Index does not exist")
                end
            else
                error("Key is not a table")
            end
        else
            error("Key does not exist")
        end

        return CachedDBs[dbName]
    end

    return DBObj
end
exports("NewDB", NewDB)

-- Auto save databases
RegisterNetEvent("onResourceStop")
AddEventHandler("onResourceStop", function(resourceName)
    if resourceName == resName then
        for key, val in pairs(CachedDBs) do
            SaveResourceFile(resName, "./db/" .. key .. ".json", json.encode(val), -1)
        end
    end
end)

local db = exports["zerio-lib"]:NewDB("test", {})

db:UpdateKey("Hello", math.random(1, 1000))

db:ForceSave()
