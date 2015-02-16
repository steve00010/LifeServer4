private["_uid", "_time_gathered"];

_uid = _this select 0;
_time_gathered = _this select 1;

//create value using get 
[_uid] call life_fnc_getPlayTime;

//set value no 1
{
	if((_x select 0) == _uid) exitWith
	{	
		_x set [1, _time_gathered];
		_x set [2, time]; //also update this time
		//no will be created @ join
		
		diag_log format["Player %1 now has playtime %2", _uid, _time_gathered];
	};
}
foreach life_playtime_values;

