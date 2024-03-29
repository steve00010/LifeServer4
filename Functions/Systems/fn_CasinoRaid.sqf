/*
	File: fn_robReserve.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Server-side part of the robbing process, runs checks and makes sure that
	two people aren't trying to both rob the same safe at the same time.
*/
private["_vault","_unit"];
_vault = [_this,0,ObjNull,[ObjNull]] call BIS_fnc_param;
_unit = [_this,1,ObjNull,[ObjNull]] call BIS_fnc_param;

if(isNull _vault OR isNull _unit) exitWith {}; //Bad data was passed.
if(!alive _unit) exitWith {}; //He's dead?
_unit = owner _unit;

if((_vault getVariable["cas_rob_ip",false])) exitWith
{
	[[1,"Someone else is already robbing the casino!"],"life_fnc_broadcast",_unit,false] spawn life_fnc_MP;
};

if((_vault getVariable["Casino_Robbed",false])) exitWith
{
	[[1,"The casino has been robbed recently already!"],"life_fnc_broadcast",_unit,false] spawn life_fnc_MP;
};

if(_unit < 1) exitWith {}; //Bad unit number passed?!
_vault setVariable["cas_rob_ip",true,true];
[[_vault,life_federal_funds],"life_fnc_RaidCasino",_unit,false] spawn life_fnc_MP;