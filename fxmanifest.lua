fx_version 'bodacious'
games { 'gta5' }

author 'Alex B. (Fouinette)'
description 'ESX Prise Fin de Service - MyCitYRP'
version '1.2.0'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'config.lua',
	'serveur/*.lua'
}

client_scripts {
	'config.lua',
	'client/*.lua'
}

dependencies {
	'es_extended',
	'mysql-async'
}
