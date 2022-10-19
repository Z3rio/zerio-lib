fx_version "cerulean"
game "gta5"

author "Zerio#0880"
description "Library of functions to allow modification of core functions in my scripts."
version "1.0.0"

shared_scripts {
    -- Uncomment if you have ESX Legacy 1.8.5 or above
    -- "@es_extended/imports.lua",
    "config.lua",
}

client_scripts {
    "client/functions.lua",
    "client/frameworks/*.lua",
}

server_scripts {
    "server/functions.lua",
    "server/frameworks/*.lua",
}
