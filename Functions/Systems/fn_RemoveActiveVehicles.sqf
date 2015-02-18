/*
File: fn_RemoveActiveVehicles.sqf
Author: Steve

Description:
Remove active vehicles before the server restarts
*/
private["_queryResult","_tickTime"];




_query ="UPDATE vehicles SET active='0' WHERE active='1' AND alive='1';";
_tickTime = diag_tickTime;
waitUntil {sleep (random 0.3); !DB_Async_Active};
_queryResult = [_query,1] call DB_fnc_asyncCall;
diag_log "------------- Client Query Request -------------";
diag_log format["QUERY: %1",_query];
diag_log format["Time to complete: %1 (in seconds)",(diag_tickTime - _tickTime)];
diag_log format["Result: %1",_queryResult];
diag_log "------------------------------------------------";
