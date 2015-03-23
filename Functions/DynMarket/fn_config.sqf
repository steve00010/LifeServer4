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
			["hen_fried",-1,30,400],
			["rabbit_grilled",-1,30,400],
			["bottles",-1,30,100],
			["cornmeal",-1,30,100],
			["rabbit_raw",-1,30,400],
			["goat_grilled",-1,30,400],
			["rooster_grilled",-1,30,400],
			["goat_raw",-1,30,200],
			["sheep_raw",-1,30,200],
			["rooster_raw",-1,30,200],
			["hen_raw",-1,30,200],
			["catshark_raw",-1,30,500],
			["sheep_grilled",-1,30,400],
			["mullet_raw",-1,30,200],
			["yeast",-1,30,100],	
			["hops",-1,30,100],	
			["rye",-1,30,100],	
			["waterBottle",-1,30,100],	
			["tbacon",-1,30,500],	
			["lockpick",-1,30,600],	
			["redgull",-1,500,900],	
			["storagesmall",-1,30000,75000],	
			["storagebig",-1,75000,150000],	
			["pickaxe",-1,100,600],	
			["underwatercharge",-1,2000,5000],	
			["mash",-1,30,100],	
			["beerp",-1,300,500],	
			["fuelFull",-1,500,700],	
			["scratchcard",-1,5000,5000],	
			["zipties",-1,300,600],	
			["oil_processed",-1,3000,6000],	
			["bottledwhiskey",-1,2000,4000],
			["bottledbeer",-1,2000,3000],	
			["cement",-1,2000,3000],	
			["coffee",-1,50,200],	
			["donut",-1,50,200],	
			["defusekit",-1,500,1500],	
			["spikeStrip",-1,300,900],	
			["monster",-1,500,900],	
			["silver_unrefined",-1,1000,2000],	
			["silver_refined",-1,2000,4000],	
			["crystal_unrefined",-1,1500,2500],	
			["crystal_refined",-1,2500,4500],	
			["diamond_cut",-1,3000,8000],	
			["diamond_uncut",-1,1500,4000],
			["salema_raw",-1,300,1000],
			["salema_grilled",-1,300,2000],
			["ornate_grilled",-1,300,2000],
			["mackerel_grilled",-1,300,2000],
			["tuna_grilled",-1,300,3000],
			["mullet_fried",-1,300,2000],
			["mackeral_raw",-1,300,1000],
			["ornate_raw",-1,300,1000],	
			["catshark_fried",-1,300,2000],	
			["glass",-1,1000,2000],	
			["copper_refined",-1,300,3000],	
			["iron_refined",-1,300,4000],	
			["salt_refined",-1,300,4000]			
		],
		0.5
	],
	["Illegal", 
		[
			["surgeryknife",-1,35000,45000],
			["kidney",-1,25000,35000],
			["blastingcharge",-1,2000,5000],
			["boltcutter",-1,300,1000],
			["turtle_raw",-1,700,1500],
			["turtle_soup",-1,1000,3000],			
			["heroin_unprocessed",-1,2000,3000],	
			["heroin_processed",-1,2000,9000],
			["cannabis",-1,1000,3000],			
			["marijuana",-1,1000,5000],	
			["cocaine_unprocessed",-1,1500,2500],	
			["cocaine_processed",-1,2000,10000],	
			["goldbar",-1,90000,175000],	
			["goldbarp",-1,45000,90000],	
			["bottledshine",-1,1000,2000],	
			["moonshine",-1,500,1500]				
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