resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'Skin Changer'

version '1.0.2'

client_scripts {
	'@extendedmode/locale.lua',
	'locale.lua',
	'locales/fr.lua',
	'config.lua',
	'client/main.lua',
	'client/module.lua'
}

server_scripts {
	"@mysql-async/lib/MySQL.lua",
	'@extendedmode/locale.lua',
	'locales/fr.lua',
	'config.lua',
	'server/main.lua'
}

dependency 'extendedmode'
