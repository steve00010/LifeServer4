/*
	File: fn_vehicleCreate.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Answers the query request to create the vehicle in the database.
*/
private["_uid","_plate","_color","_vehicle"];
_uid = _this select 0;
_plate = _this select 1;
_color = _this select 2;
_vehicle = _this select 3;
[[_vehicle,_color],"life_fnc_colorVehicle",nil,false] spawn life_fnc_MP;
_query = format["UPDATE vehicles SET color='%3' WHERE pid='%1' AND plate='%2'",_uid,_plate,_color];

waitUntil {!DB_Async_Active};
_sql = [_query,1] call DB_fnc_asyncCall;
