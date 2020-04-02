# esx_priseservice
 Prise et Fin de Service pour les métiers

# Configuration
 La seule configuration nécessaire, c'est la création d'un grade pour chaque métiers avec le code grade 99.
 
# Utilisation
 Pour passer un joueur En/Hors Service, soit on utilise la commande /service
 Soit on passe par un Trigger Client
 TriggerClientEvent('esx_priseservice:CLT_prise');
 TriggerEvent('esx_priseservice:CLT_prise');
 TriggerClientEvent('esx_priseservice:CLT_hors');
 TriggerEvent('esx_priseservice:CLT_hors');