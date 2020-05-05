resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'ESX Prise Fin de Service - MyCitYRP'

version '1.0.0'

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
