Citizen.CreateThread(function()
    if Config.VersionCheck ~= false then
        local currVersion = GetResourceMetadata(GetCurrentResourceName(), 'version', 0)
        if currVersion == nil then
            print('Zerio-Library [VersionCheck] | Failed to find script version')
        end

        PerformHttpRequest('https://raw.githubusercontent.com/Zerio-Scripts/version-checks/main/versions.json',
            function(code, resp, headers)
                if code == 200 then
                    local newestVersion = tostring(json.decode(resp).library.currentversion)
                    if tostring(currVersion) == tostring(newestVersion) then
                        print("Zerio-Library [VersionCheck] | The script is up to date")
                    else
                        print("Zerio-Library [VersionCheck] | The script is updated. You are on version " ..
                                  tostring(currVersion) .. ", the newest version is " .. tostring(newestVersion))
                    end
                else
                    print("Zerio-Library [VersionCheck] | Failed to fetch current version")
                end
            end, 'GET')
    end
end)
