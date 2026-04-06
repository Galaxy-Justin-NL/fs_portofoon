fx_version 'cerulean'
game 'gta5'

author 'Galaxy_justin'
description 'Fs-Radio: Modern ESX Radio met Schouder Animatie'
version '1.0.0'

shared_script '@ox_lib/init.lua'

client_scripts {
    'client.lua'
}

server_scripts {
    'server.lua'
}

dependencies {
    'es_extended',
    'pma-voice',
    'ox_lib'
}
