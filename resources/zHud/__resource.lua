resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

version '1.0'

client_scripts {
	'status/config.lua',
	'status/client/classes/status.lua',
	'status/client/main.lua',
	'basics/client/alcole_cl.lua',
    'basics/client/bouf_cl.lua',
	'hud/client.lua',
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'status/config.lua',
	'status/server/main.lua',
	'basics/server/alcole_sv.lua',
    'basics/server/bouf_sv.lua',
}

client_script 'hud/client.lua'

files {
    'hud/index.html'
}
ui_page 'hud/index.html'