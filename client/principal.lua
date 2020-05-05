--================================
-- Développé par Fouinette
-- Pour le projet MyCitY RP
--================================
PlayerLoaded	= false;
enService		= true;
ESX				= nil;

-- Initialisation du FrameWork ESX.
function initESX()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10);
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100);
	end

	PlayerLoaded	= true;
	ESX.PlayerData	= ESX.GetPlayerData();
end

Citizen.CreateThread(function()
	initESX();
end)

-- Chargement du joueur
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer;
	PlayerLoaded = true;
	if ESX.PlayerData.job.grade ~= 99 and ESX.PlayerData.job ~= nil then
		TriggerServerEvent('esx_priseservice:SRV_loaded');
		enService = true;
	else
		enService = false;
	end
end)

-- Dans le cas d'un changement de boulot
RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	if ESX.PlayerData.job.name ~= job.name then
		ESX.PlayerData.job = job;
		enService = true;
		TriggerServerEvent('esx_priseservice:SRV_loaded');
		print('Changement de métier')
	else
		ESX.PlayerData.job = job;
		print('Prise Fin de service')
	end
end)

-- Trigger de mise à jour client
RegisterNetEvent('esx_priseservice:CLT_update')
AddEventHandler('esx_priseservice:CLT_update', function(etat)
	enService = etat;
end)

-- Trigger de prise de service.
RegisterNetEvent('esx_priseservice:CLT_prise')
AddEventHandler('esx_priseservice:CLT_prise', function()
	if estAutorise() then
		TriggerServerEvent('esx_priseservice:SRV_prise');
		enService = true;
	end
end)

-- Trigger de fin de service.
RegisterNetEvent('esx_priseservice:CLT_hors')
AddEventHandler('esx_priseservice:CLT_hors', function()
	if estAutorise() then
		-- TriggerServerEvent('esx_priseservice:SRV_loaded');
		TriggerServerEvent('esx_priseservice:SRV_hors');
		enService = false;
	end
end)

-- Commande /service pour changer d'état.
RegisterCommand("service", function(source, args, raw) --change command here
	print('ESX_PRISESERVICE: ' .. tostring(enService))
	if enService then
		TriggerEvent("esx_priseservice:CLT_hors");
	else
		TriggerEvent("esx_priseservice:CLT_prise");
	end
end, false) --False, allow everyone to run it

-- Fonctions outils
function estAutorise()
	for _,i in pairs(Config.Metiers) do
		print('ESX_PRISESERVICE: ' .. i .. '-' .. ESX.PlayerData.job.name)
		if i == ESX.PlayerData.job.name then
			print('ESX_PRISESERVICE: Autorise')
			return true;
		end
	end
			print('ESX_PRISESERVICE: Non Autorise')
	return false;
end
