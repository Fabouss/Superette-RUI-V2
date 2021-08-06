fx_version 'adamant'

game 'gta5'

client_scripts {
    "src/RMenu.lua",
    "src/menu/RageUI.lua",
    "src/menu/Menu.lua",
    "src/menu/MenuController.lua",

    "src/components/*.lua",

    "src/menu/elements/*.lua",

    "src/menu/items/*.lua",

    "src/menu/panels/*.lua",

    "src/menu/panels/*.lua",
    "src/menu/windows/*.lua",

}

client_scripts {
    'fab_asc/client/cl_fib.lua',
    'fab_shop/client/client.lua',
    'config.lua'
}

server_scripts {
    'fab_asc/server/server.lua',
    '@mysql-async/lib/MySQL.lua',
    'fab_shop/server/server.lua',
    'config.lua'
}
