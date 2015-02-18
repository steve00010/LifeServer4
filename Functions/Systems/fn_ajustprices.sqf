/*
File: fn_Ajustprices.sqf
Author: worldtrade1101

Description:
Sends a request to update and adjust the price of stuff in the DB.
*/

//[[0,player,life_shop_type,_amount,_price,_var],"TON_fnc_Adjustprices",false,false] spawn life_fnc_MP;
private["_type","_side","_data","_unit","_ret","_tickTime","_queryResult","_var","_price","_amount","_group","_AllOk","_i"];
_type = [_this,0,0,[0]] call BIS_fnc_param;
_unit = [_this,1,ObjNull,[ObjNull]] call BIS_fnc_param;
_data = [_this,2,"",[""]] call BIS_fnc_param;
_amount = [_this,3,0,[0]] call BIS_fnc_param;
_price = [_this,4,0,[0]] call BIS_fnc_param;
_var = [_this,5,"",[""]] call BIS_fnc_param;

_i=0;
//Error checks

diag_log format ["%1   %2    %3    %4      %5      %6",_unit,_type,_data,_amount,_price,_var];
if( (_data == "") OR (isNull _unit)) exitWith
{
diag_log "data ou type ou unit null";
};
_sellingfactor = 0;
_unit = owner _unit; //for hack purpose!

//we randomize the thing to not update every single transaction
_randomnumber = random 100;

if (_randomnumber < 30) exitwith {diag_log "This transaction doesn't update the price!"};
_group = -1;

{
	if(_x select 0 == _var) then {
		_group = _x select 1;
		_sellingfactor = _sellingfactor + 1;
	};

} forEach life_economy;



_AllOk = TRUE;
{
	if(_x select 1 == _group) then {
		//diag_log format ["test : %1 (%2)", _this , typeName _this];
		//diag_log format ["var : %1 (%2)", _var , typeName _var];
		_ressource = _x select 0;
		//diag_log format ["ressource : %1 (%2)", _ressource  , typeName _ressource ];
		_buyprice =  (_x select 3);
		_sellprice =  (_x select 4);
		_varprice =  (_x select 5);
		_minprice = (_x select 6);
		_maxprice = (_x select 7);
		//diag_log format["1IST: %1,%2,%3,%4,%5,%6,%7,%8,%9,%10",_ressource,_buyprice,_sellprice,_varprice,_minprice,_maxprice,_var,_type,_amount,_sellingfactor];
		if (_ressource == _var) then { //C'est l'item vendu ou achete
			if (_type == 0) then {//si on vend l'item
				if (_buyprice != 0) then {
					if((_buyprice - (_varprice * _amount)) > _minprice) then {
						_buyprice= _buyprice - (_varprice * _amount);
					}
					else {
						_buyprice = _minprice;
						//_AllOk = false;
					};
				};
				if ((_sellprice - (_varprice * _amount * _sellingfactor)) > _minprice) then {
					_sellprice = _sellprice - (_varprice * _amount *_sellingfactor);
				}
				else {
					_sellprice = _minprice + 1;
					//_AllOk = false;
				};
				if (_buyprice != 0) then {
					if ((_sellprice >= _buyprice)) then {
						_buyprice=_sellprice + 15
					};
				};
			} 
			else {//si on achete l'item
				if (_buyprice != 0) then {
					if((_buyprice + (_varprice * _amount)) < (_maxprice+15)) then {
					_buyprice = _buyprice + (_varprice * _amount);
					}
					else {
					_buyprice = _maxprice;
					//	_AllOk = false;
					};
				};
				if ((_sellprice + (_varprice * _amount)) < _maxprice) then {
				_sellprice = _sellprice + (_varprice * _amount)
				;}
				else {
				_sellprice = _maxprice;
			//	_AllOk = false;
				};
			};
		} else {
			if (_type == 0) then {//si on a vendu un autre item on augmente le prix
				if (_buyprice != 0) then {
					if( (_buyprice + (_varprice * _amount)) < (_maxprice)) then {
						_buyprice = _buyprice + (_varprice * _amount);
					}
					else {
					_buyprice = _maxprice;
					//	_AllOk = false;
						};
					};
				if ((_sellprice + (_varprice * _amount)) < _maxprice) then {
					_sellprice = _sellprice + (_varprice * _amount);
				} 
				else {
				_sellprice = _maxprice;
				//	_AllOk = false;
				};

			} else { //si on achete un autre item on baisse le prix
				if (_buyprice != 0) then {
					if( (_buyprice - (_varprice * _amount)) > _minprice ) then {
						_buyprice= _buyprice - (_varprice * _amount);
						} else {
						_buyprice = _minprice;
					//	_AllOk = false;
						};
					};
				if ((_sellprice - (_varprice * _amount)) > _minprice) then {
				_sellprice = _sellprice - (_varprice * _amount);
				}else {
				_sellprice = _minprice + 1;
				//	_AllOk = false;
				};
			};
		};
		_index = [_ressource,life_economy] call TON_fnc_index;
	//	diag_log format["RES: %1",_ressource];
	//	diag_log format["BUY:%1, SELL: %2",_x select 3,_x select 4];
	//	diag_log format["BUY1:%1, SELL1: %2",_buyprice,_sellprice];
		
		life_economy set[_index,[_ressource,_group,_x select 2,_buyprice,_sellprice,_varprice,_minprice,_maxprice]];
	
	};
}forEach life_economy;
