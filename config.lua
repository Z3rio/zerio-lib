Config = {}

Config.OwnedResources = {}

-- If you have ESX Legacy 1.8.5 or above, then uncomment the line in fx-manifest.lua.
-- DONT TOUCH!!! This is automatick
Config.Framework = ""
if GetResourceState("qb-core") ~= "missing" then
  Config.Framework = "qb-core"
end
if GetResourceState("es_exended") ~= "missing" then
  Config.Framework = "esx"
end
