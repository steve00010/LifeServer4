/*
	File: fn_wantedTicket.sqf
	Author: Steve
	
	Description:
	Checks the price of the ticket against the bounty, if => then bounty remove them from the wanted list.
*/
private["_price","_uid","_ind","_entry","_query","_queryResult","_data","_val"];
_uid = [_this,0,"",[""]] call BIS_fnc_param;
_price = [_this,1,0,[0]] call BIS_fnc_param;
if(_uid == "" OR _price == 0) exitWith {};
_ind = [_uid,life_wanted_list] call TON_fnc_index;
_data = life_wanted_list select _ind;
_val = _data select 3;
if(_price < _val) exitWith {};
if(_index != -1) then
{
	life_wanted_list set[_index,-1];
	life_wanted_list = life_wanted_list - [-1];
};
diag_log format["WANTED_LIST = %1", life_wanted_list];
_query = format["DELETE from wanted WHERE pid='%1';",_uid];


waitUntil {sleep (random 0.3); !DB_Async_Active};_queryResult = [_query,1] call DB_fnc_asyncCall;