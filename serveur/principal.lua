--================================
-- Développé par Fouinette
-- Pour le projet MyCitY RP
--================================
ESX	= nil;
local attente = 0;

-- Initialisation du FrameWork
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- Trigger de mise à jour de la BDD
RegisterNetEvent('esx_priseservice:SRV_loaded')
AddEventHandler('esx_priseservice:SRV_loaded', function()
	-- Normalement appelé au chargement du joueur par le script
	-- SQL -->	INSERT INTO `prisesdeservices` ( identifier, job, grade )
	--			VALUES (@identifier, @job, @grade)
	--			ON DUPLICATE KEY UPDATE job = @job, grade = @grade
	--			WHERE identifier = @identifier;
	local xPlayer	= ESX.GetPlayerFromId(source);	-- Récupération de xPlayer
	local job		= xPlayer.getJob().name;		-- String
	local grade		= xPlayer.getJob().grade;		-- Int
	local identifier= xPlayer.getIdentifier();		-- String
	MySQL.Async.execute(
		[[INSERT INTO `prisesdeservices` ( identifier, job, grade )
		VALUES ( @identifier, @job, @grade )
		ON DUPLICATE KEY UPDATE job = @job, grade = @grade;]], -- La requête paramêtrée.
		{ -- Liste des paramêtres
			['@identifier']	= identifier,
			['@job']		= job,
			['@grade']		= grade
		},
		nil -- Pas de fonction CallBack
	);
end)

-- Trigger gestion de service
RegisterNetEvent('esx_priseservice:SRV_prise');
AddEventHandler('esx_priseservice:SRV_prise', function()
	-- Dans le cas d'une prise de service
	local xPlayer	= ESX.GetPlayerFromId(source);
	local job		= xPlayer.getJob().name;		-- String
	local identifier= xPlayer.getIdentifier();		-- String
	MySQL.Async.execute(
		'UPDATE `prisesdeservices` SET onoff = 1 WHERE identifier = @identifier',
		{
			['@identifier']	= identifier
		},
		nil
	);
	MySQL.Async.fetchAll(
		'SELECT grade FROM `prisesdeservices` WHERE identifier = @identifier',
		{
			['@identifier'] = identifier
		},
		function(grade)
			-- Attribution du grade En Service
			print('ESX_PRISESERVICE: ' .. grade[1].grade)
			xPlayer.setJob(job, grade[1].grade);
			TriggerClientEvent('esx_priseservice:CLT_update', source, 1)
		end
	);
end)

RegisterNetEvent('esx_priseservice:SRV_hors');
AddEventHandler('esx_priseservice:SRV_hors', function()
	-- Dans le cas d'une fin de service
	local xPlayer	= ESX.GetPlayerFromId(source);
	local job		= xPlayer.getJob().name;		-- String
	local identifier= xPlayer.getIdentifier();		-- String
	MySQL.Async.execute(
		'UPDATE `prisesdeservices` SET onoff = 0 WHERE identifier = @identifier',
		{
			['@identifier']	= identifier
		},
		nil
	);
	print('ESX_PRISESERVICE: ' .. job);
	xPlayer.setJob(job, 99);
end)