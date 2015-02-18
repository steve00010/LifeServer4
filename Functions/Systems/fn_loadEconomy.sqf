/*
File: fn_loadEconomy.sqf
Author: Steve

Description:
Send a query to retrieve the price of stuff on the server
*/
private["_type","_side","_data","_unit","_ret","_tickTime","_queryResult"];

_query = "SELECT ressource, buyprice, sellprice, shoptype,factor, varprice, minprice, maxprice FROM economy ORDER BY ressource";



if(_query == "Error") exitWith {
diag_log "error";
};

waitUntil{sleep (random 0.3); !DB_Async_Active};
_tickTime = diag_tickTime;
_queryResult = [_query,2,true] call DB_fnc_asyncCall;

diag_log "------------- Client Query Request -------------";
diag_log format["QUERY: %1",_query];
diag_log format["Time to complete: %1 (in seconds)",(diag_tickTime - _tickTime)];
diag_log format["Result: %1",_queryResult];
diag_log "------------------------------------------------";

{
	_resource = _x select 0;
	_buyprice = _x select 1;
	_sellprice = _x select 2;
	_shoptype = _x select 3;
	_factor = _x select 4;
	_varprice = _x select 5;
	_minprice = _x select 6;
	_maxprice = _x select 7;
	life_economy pushBack [_resource,_factor,_shoptype,_buyprice,_sellprice,_varprice,_minprice,_maxprice];

} forEach _queryResult;


//diag_log format["ECON: %1",life_economy];

