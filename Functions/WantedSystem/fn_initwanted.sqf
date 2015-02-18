private ["_query","_queryResult","_crimes","_bounty"];
_uid = [_this,0,"",[""]] call BIS_fnc_param;
_name = [_this,1,"",[""]] call BIS_fnc_param;
_query = format["SELECT charges,bounty from wanted where pid='%1'",_uid];
diag_log format["Loading %1's wanted list from DB",_name];
waitUntil{sleep (random 0.3); !DB_Async_Active};
_queryResult = [_query,2] call DB_fnc_asyncCall;
if(count _queryResult != 0) then {
	_crimes = _queryResult select 0;
	_bounty = _queryResult select 1;
	diag_log format["%1 is wanted! Crimes: %2, Bounty: %3",_name,_crimes,_bounty];
	life_wanted_list pushBack [_name,_uid,_crimes,_bounty];
};