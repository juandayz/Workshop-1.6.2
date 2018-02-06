private ["_position","_nearanimalhouse","_nearanimal","_animals","_hasitem1","_removed","_animal","_objet","_positionobj"];



//DEFINES///

_position = getPosATL player;
_nearanimalhouse = count nearestObjects [_position, ["MAP_Shed_W01"], 25] > 0;

_objet = nearestObject [player, "MAP_Shed_W01"];
_positionobj = getPosATL _objet;

_nearanimal = count nearestObjects [_position, ["Hen","WildBoar","Cow03","Sheep01_EP1"], 25] > 3;
_hasitem1 = [["ItemBurlap",1], "ItemWaterBottle"] call player_checkItems;

//CHECK ITEMS AND NEAREST///

if (!_hasitem1) exitWith {cutText [format["Needs 1xItemBurlap + 1xWaterBottle"], "PLAIN DOWN"];

dayz_actionInProgress = false;

};

if (_nearanimal) exitWith {cutText [format["your not allowed to breed more than 4 animals"], "PLAIN DOWN"];
dayz_actionInProgress = false;
};


if (_nearanimalhouse && _hasitem1) then {


//SPAWN OBJET//

player playActionNow "Medic";
[player,"repair",0,false,10] call dayz_zombieSpeak;
[player,10,true,(getPosATL player)] spawn player_alertZombies;
player removeMagazine "ItemBurlap";
player removeMagazine "ItemWaterBottle";
player addMagazine "ItemWaterbottleUnfilled"; 
sleep 1;
cutText [format["Your Own Animal!"], "PLAIN DOWN"];

sleep 3;
_animals = ["Hen","WildBoar","Cow03","Sheep01_EP1"] call BIS_fnc_selectRandom;	

_this = createCenter civilian;
_center_2 = _this;

_group_2 = createGroup _center_2;

_animal = objNull;
if (true) then
{
  _this = _group_2 createUnit [_animals,_positionobj, [], 6, "CAN_COLLIDE"] call BIS_fnc_findSafePos;	
  _animal = _this;
  _this setUnitAbility 0.60000002;

};

} else{
cutText [format["You needs an animal house!!"], "PLAIN DOWN"];
dayz_actionInProgress = false;
};
dayz_actionInProgress = false;

