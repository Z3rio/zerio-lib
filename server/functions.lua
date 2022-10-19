if Config.Framework == "qb-core" then
  Framework = exports["qb-core"]:GetCoreObject()
elseif Config.Framework == "esx" then
  if ESX then
    Framework = ESX
  end
  else
    TriggerEvent("esx:getSharedObject", function(obj) Framework = obj end)
  end
end
