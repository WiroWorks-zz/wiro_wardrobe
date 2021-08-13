fx_version "adamant" -- bodacious

game "gta5"

client_script {
    'client.lua'
}

server_script "@mysql-async/lib/MySQL.lua"

server_script {
    'server.lua'
}

ui_page('UI/index.html')

files {
    "UI/index.html",
    "UI/style.css",
    "UI/index.js",
}