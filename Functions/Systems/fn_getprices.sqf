/*
File: fn_getPrices.sqf
Author: Worldtrade1101

Description:
Send a query to retrieve the price of stuff on the server
*/
private["_type","_side","_data","_unit","_ret","_tickTime","_queryResult","_query"];
_type = [_this,0,0,[0]] call BIS_fnc_param;
_unit = [_this,1,ObjNull,[ObjNull]] call BIS_fnc_param;
_data= [_this,2,"",[""]] call BIS_fnc_param;
_queryResult = [];

_query = "";
//Error checks

diag_log format ["%1   %2    %3",_unit,_type,_data];
if( (_data == "") OR (isNull _unit)) exitWith
{

diag_log "data ou type ou unit null";
/*if(!isNull _unit) then
{
[[[]],"life_fnc_impoundMenu",(owner _unit),false] spawn life_fnc_MP;
}; */
};

_unit = owner _unit;


switch (_data) do {



case "market" :{  _query =  "name"};
case "heroin" :{ _query =  "name"};
case "rebel" :{ _query =  "rebel"};
case "fishmarket" :{ _query =  "name"};
case "wongs" :{ _query = "name"};
case "oil" :{  _query =  "name"};
case "cop" :{ _query =  "name"};
case "diamond" :{_query =   "name"};
case "iron" :{ _query =  "name"};
case "glass" :{_query =   "name"};
case "salt" :{ _query =  "name"};
case "cement" :{ _query =  "name"};
case "gold" :{ _query =  "name"};
case "bar" :{ _query =  "name"};
case "organ" :{ _query =  "name"};
case "gang" :{ _query =  "rebel"};
case "economy" :{_query =  "economy"};
case "crystal" :{_query = "crystal"};
default {_query =  "Error"};
};


{
	if(_query == "name") then {
		//diag_log format["x1: %1, data: %2",_x select 1,_data];
		if(_x select 2 == _data) then {
			_queryResult pushback [_x select 0, _x select 3,_x select 4];
		};
	};
	if(_query == "rebel") then {	
		if(_x select 2 == _data OR _x select 2 == "market" ) then {
			_queryResult pushback [_x select 0, _x select 3,_x select 4];
		};
	};
	if(_query == "economy") then {
		_queryResult pushback [_x select 0, _x select 3,_x select 4];
	};

} forEach life_economy;

//diag_log format["QR: %1",_queryResult];

if (_data == "economy") exitwith {[[_type,_queryResult],"life_fnc_virt_updateEconomy",_unit,false] spawn life_fnc_MP;};

[[_type,_queryResult],"life_fnc_virt_updateprice",_unit,false] spawn life_fnc_MP;