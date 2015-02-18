/*
File: fn_saveEconomy.sqf
Author: Steve

Description:
Send a query to save the prices of stuff on the server economy
*/
private["_queryResult","_tickTime"];
_queryArray = [];

{

_query =format["UPDATE economy SET buyprice='%1', sellprice='%2' WHERE ressource='%3'",_x select 3,_x select 4,_x select 0];
_queryArray pushBack _query;

} forEach life_economy;

{
	_tickTime = diag_tickTime;
	waitUntil {sleep (random 0.3); !DB_Async_Active};
	_queryResult = [_x,1] call DB_fnc_asyncCall;
	diag_log "------------- Client Query Request -------------";
	diag_log format["QUERY: %1",_x];
	diag_log format["Time to complete: %1 (in seconds)",(diag_tickTime - _tickTime)];
	diag_log format["Result: %1",_queryResult];
	diag_log "------------------------------------------------";
}forEach _queryArray;