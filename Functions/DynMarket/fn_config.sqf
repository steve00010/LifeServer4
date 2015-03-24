/*
##################### DYNAMIC MARKET SCRIPT #####################
### AUTHOR: RYAN TT.                                          ###
### STEAM: www.steamcommunity.com/id/ryanthett                ###
###                                                           ###
### DISCLAIMER: THIS SCRIPT CAN BE USED ON EVERY SERVER ONLY  ###
###             WITH THIS HEADER / NOTIFICATION               ###
#################################################################
*/

// ███████████████████████████████████████████████████████████████████████
// █████████████████ DYNAMIC MARKET BASIC CONFIGURATION ██████████████████
// ███████████████████████████████████████████████████████████████████████

DYNMARKET_Serveruptime         = 04;   // Serveruptime after restart in hours
DYNMARKET_UseExternalDatabase  = true; // Should the script use the External Database?
DYNMARKET_PriceUpdateInterval  = 10;   // After how many minutes should the price be updated?
DYNMARKET_CreateBackups        = true; // Should the server save write the prices regulary into the Database? If false, it will save the prices before Server-restart?
DYNMARKET_CreateBackupInterval = 15;   // After how many updates (PriceUpdateIntervals) should the prices be saved into the Database?
DYNMARKET_UserNotification     = true; // Should the user be informed with a hint whenever the prices got updated?

// █████████████████ USER NOTIFICATION TEXTS  █████████████████

DYNMARKET_UserNotification_Text = 
[
	"Your prices have been updated!",
	"The new prices are being calculated by the server..."
];

// █████████████████ ITEM GROUP CONFIGURATION █████████████████

DYNMARKET_Items_Groups =
[
	["Legal",
		[
			["apple",-1,30,100],
			["peach",-1,30,100],
			["hen_fried",-1,30,100],
			["rabbit_grilled",-1,30,100],
			["bottles",-1,30,100],
			["cornmeal",-1,30,100],
			["rabbit_raw",-1,30,100],
			["goat_grilled",-1,30,100],
			["rooster_grilled",-1,30,100],
			["goat_raw",-1,30,100],
			["sheep_raw",-1,30,100],
			["rooster_raw",-1,30,100],
			["hen_raw",-1,30,100],
			["catshark_raw",-1,30,100],
			["sheep_grilled",-1,30,100],
			["mullet_raw",-1,30,100],
			["yeast",-1,30,100],	
			["hops",-1,30,100],	
			["rye",-1,30,100],	
			["waterBottle",-1,30,100],	
			["tbacon",-1,30,100],	
			["lockpick",-1,30,100],	
			["redgull",-1,30,100],	
			["storagesmall",-1,30,100],	
			["storagebig",-1,30,100],	
			["pickaxe",-1,30,100],	
			["underwatercharge",-1,30,100],	
			["mash",-1,30,100],	
			["beerp",-1,30,100],	
			["fuelFull",-1,30,100],	
			["scratchcard",-1,30,100],	
			["zipties",-1,30,100],	
			["oil_processed",-1,30,100],	
			["bottledwhiskey",-1,30,100],
			["bottledbeer",-1,30,100],	
			["cement",-1,30,100],	
			["coffee",-1,30,100],	
			["donut",-1,30,100],	
			["defusekit",-1,30,100],	
			["spikeStrip",-1,30,100],	
			["monster",-1,30,100],	
			["silver_unrefined",-1,30,100],	
			["silver_refined",-1,30,100],	
			["crystal_unrefined",-1,30,100],	
			["crystal_refined",-1,30,100],	
			["diamond_cut",-1,30,100],	
			["diamond_uncut",-1,30,100],
			["salema_raw",-1,30,100],
			["salema_grilled",-1,30,100],
			["ornate_grilled",-1,30,100],
			["mackerel_grilled",-1,30,100],
			["tuna_grilled",-1,30,100],
			["mullet_fried",-1,30,100],
			["mackeral_raw",-1,30,100],
			["ornate_raw",-1,30,100],	
			["catshark_fried",-1,30,100],	
			["glass",-1,30,100],	
			["copper_refined",-1,30,100],	
			["iron_refined",-1,30,100],	
			["salt_refined",-1,30,100]			
		],
		0.5
	],
	["Illegal", 
		[
			["surgeryknife",-1,30,100],
			["kidney",-1,30,100],
			["blastingcharge",-1,30,100],
			["boltcutter",-1,30,100],
			["turtle_raw",-1,30,100],
			["turtle_soup",-1,30,100],			
			["heroin_unprocessed",-1,30,100],	
			["heroin_processed",-1,20,100],
			["cannabis",-1,20,100],			
			["marijuana",-1,20,100],	
			["cocaine_unprocessed",-1,20,100],	
			["cocaine_processed",-1,20,100],	
			["goldbar",-1,20,100],	
			["goldbarp",-1,20,100],	
			["bottledshine",-1,20,100],	
			["moonshine",-1,20,100]				
		],
		0.5
	]
];

// █████████████████    ALL SELLABLE ITEMS    █████████████████

DYNMARKET_Items_ToTrack        = 
[
	["apple",25],
	["peach",50],
	["salema",45],
	["ornate",40],
	["mackerel",175],
	["tuna",700],
	["mullet",250],
	["catshark",300],
	["rabbit",65],
	["turtle",30077],
	["water",5],
	["coffee",5],
	["turtlesoup",1000],
	["donuts",60],
	["tbacon",25],
	["lockpick",75],
	["pickaxe",750],
	["redgull",200],
	["fuelF",100],
	["spikeStrip",1200],
	["goldbar",125000],
	["cocainep",5348],
	["heroinp",4527],
	["marijuana",4365],
	["iron_r",3017],
	["copper_r",3746],
	["salt_r",4759],
	["glass",3368],
	["oilp",2571],
	["cement",3342],
	["diamondc",3566]
];

//███████████████████████████████████████████████████████████████████████
//██████████████████ DO NOT MODIFY THE FOLLOWING CODE! ██████████████████
//███████████████████████████████████████████████████████████████████████

DYNMARKET_Items_CurrentPriceArr = [];
DYNMARKET_sellarraycopy = DYNMARKET_Items_ToTrack;
DYNMARKET_Serveruptime = (DYNMARKET_Serveruptime * 3600) - 60;
{
	_currentArray = _x;
	DYNMARKET_Items_CurrentPriceArr pushBack [_currentArray select 0,_currentArray select 1,0];
} forEach DYNMARKET_Items_ToTrack;
publicVariable "DYNMARKET_UserNotification";
publicVariable "DYNMARKET_UserNotification_Text";
if (DYNMARKET_UseExternalDatabase) then {[1] call TON_fnc_HandleDB;};
DYNMARKET_UpdateCount = 0;
[] spawn {
	sleep DYNMARKET_Serveruptime;
	diag_log "### DYNMARKET >> CURRENT PRICES ARE BEING WRITTEN TO THE DATABASE    ###";
	diag_log "### DYNMARKET >> AS PLANNED, AWAITING RESULT...                      ###";
	[0] call TON_fnc_HandleDB;
};
sleep 5;
[] call TON_fnc_sleeper;