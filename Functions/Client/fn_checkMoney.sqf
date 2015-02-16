private ["_time","_unit","_id"];

_time = [_this select 0] call life_fnc_getPlayTime;
_unit = [_this,1,Objnull,[Objnull]] call BIS_fnc_param;
_id = owner _unit;


[[_time],"SOCK_fnc_moneyCheck",_id,false] spawn life_fnc_MP;