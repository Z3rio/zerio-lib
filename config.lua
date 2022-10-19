Config = {}

Config.OwnedResources = {}

Config.Framework = ""
if GetResourceState("qb-core") ~= "missing" then
  Config.Framework = "qb-core"
end
if GetResourceState("es_exended") ~= "missing" then
  Config.Framework = "esx"
end
