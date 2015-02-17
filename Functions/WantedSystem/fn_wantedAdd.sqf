/*
	File: fn_wantedAdd.sqf
	Author: Bryan "Tonic" Boardwine"
	Database Persistence By: ColinM
	Assistance by: Paronity
	Stress Tests by: Midgetgrimm
	
	Description:
	Adds or appends a unit to the wanted list.
*/
private["_uid","_type","_index","_data","_crimes","_val","_customBounty","_name","_pastCrimes","_query","_queryResult"];
_uid = [_this,0,"",[""]] call BIS_fnc_param;
_name = [_this,1,"",[""]] call BIS_fnc_param;
_type = [_this,2,"",[""]] call BIS_fnc_param;
_customBounty = [_this,3,-1,[0]] call BIS_fnc_param;
if(_uid == "" OR _type == "" OR _name == "") exitWith {}; //Bad data passed.

//What is the crime?
switch(_type) do
{
	case "187V": {_type = ["187V",6500]};
	case "187": {_type = ["187",20000]};
	case "901": {_type = ["901",4500]};
	case "215": {_type = ["215",2000]};
	case "213": {_type = ["213",10000]};
	case "211": {_type = ["211",1000]};
	case "207": {_type = ["207",3500]};
	case "207A": {_type = ["207A",2000]};
	case "390": {_type = ["390",15000]};
	case "487": {_type = ["487",1500]};
	case "488": {_type = ["488",700]};
	case "480": {_type = ["480",1300]};
	case "481": {_type = ["481",1000]};
	case "482": {_type = ["482",5000]};
	case "483": {_type = ["483",9500]};
	case "459": {_type = ["459",6500]};
	case "666": {_type = ["666",2000]};
	case "667": {_type = ["667",45000]};
	case "668": {_type = ["668",15000]};
	
	case "1": {_type = ["1",350]};
    case "2": {_type = ["2",1500]};
    case "3": {_type = ["3",2500]};
    case "4": {_type = ["4",3500]};
    case "5": {_type = ["5",8000]};
    case "6": {_type = ["6",5000]};
	case "7": {_type = ["7",10000]};
	default {_type = [];};
};

if(count _type == 0) exitWith {}; //Not our information being passed...
//Is there a custom bounty being sent? Set that as the pricing.
if(_customBounty != -1) then {_type set[1,_customBounty];};
//Search the wanted list to make sure they are not on it.
_index = [_uid,life_wanted_list] call TON_fnc_index;

if(_index != -1) then
{
	_data = life_wanted_list select _index;
	_crimes = _data select 2;
	_crimes pushBack (_type select 0);
	_val = _data select 3;
	life_wanted_list set[_index,[_name,_uid,_crimes,(_type select 1) + _val]];
	diag_log format["Inserting  new player into wanted DB"];
	_query = format["Replace into wanted (pid,charges,bounty) values('%2','%1','%3');", _crimes, _uid,(_type select 1) + _val];
	waitUntil {sleep (random 0.3); !DB_Async_Active};
	_queryResult = [_query,1] call DB_fnc_asyncCall;
}
	else
{
	life_wanted_list pushBack [_name,_uid,[(_type select 0)],(_type select 1)];
	diag_log format["Inserting player into wanted DB"];
	_query = format["Replace into wanted (pid,charges,bounty) values('%2','%1','%3');", [(_type select 0)], _uid,(_type select 1)];
	waitUntil {sleep (random 0.3); !DB_Async_Active};
	_queryResult = [_query,1] call DB_fnc_asyncCall;
};
diag_log format["WANTED_LIST = %1", life_wanted_list];