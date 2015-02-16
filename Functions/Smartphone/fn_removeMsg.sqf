/*

	file: fn_removeMsg.sqf
	Author: Steve

	Description: Deletes specified message
*/

private["_player","_query","_message"];
_player = [_this,0,ObjNull,[objNull]] call BIS_fnc_param;
_message = [_this,1,"",[""]] call BIS_fnc_param;
if(isNull _player) exitWith {};

_query = format["DELETE FROM messages WHERE toID='%1' AND message='""%2""'",getPlayerUID _player,_message];
diag_log format["%1", _query];
waitUntil{!DB_Async_Active};
[_query,1] call DB_fnc_asyncCall;