private ["_inventory","_hasknife","_hasitems","_playerPos","_nearRestr","_removed"];

_inventory = items player;
_hasknife = "ItemKnife" in _inventory;
_hasitems = [["PartWoodPile",12]] call player_checkItems;
_playerPos = getPosATL player;
_nearRestr = count nearestObjects [_playerPos, ["MAP_P_Stavebni_kozy"], 35] > 0;

if !(_nearRestr) exitWith {
cutText [format["Needs be near of Carpenter Bench"], "PLAIN DOWN"]; 
 dayz_actionInProgress = false;
	};
	
if !(_hasknife) exitWith {
	cutText [format["Must be equiped with 1x knife in your toolbet."], "PLAIN DOWN"];
	dayz_actionInProgress = false;
};

if !(_hasitems) exitWith {
	cutText [format["Needs 12xWoodPiles in your inventory."], "PLAIN DOWN"];
	dayz_actionInProgress = false;
};

if (_nearRestr && _hasknife && _hasitems) then {
player playActionNow "Medic";
[player,"repair",0,false,10] call dayz_zombieSpeak;
[player,10,true,(getPosATL player)] spawn player_alertZombies;
sleep 5;
	
player removeMagazine "PartWoodPile";
player removeMagazine "PartWoodPile";
player removeMagazine "PartWoodPile";
player removeMagazine "PartWoodPile";
player removeMagazine "PartWoodPile";
player removeMagazine "PartWoodPile";
player removeMagazine "PartWoodPile";
player removeMagazine "PartWoodPile";
player removeMagazine "PartWoodPile";
player removeMagazine "PartWoodPile";
player removeMagazine "PartWoodPile";
player removeMagazine "PartWoodPile";
sleep 1;
player addMagazine "PartWoodLumber";
player addMagazine "PartWoodLumber";
player addMagazine "PartWoodLumber";
player addMagazine "PartWoodLumber";
player addMagazine "PartWoodLumber";
player addMagazine "PartWoodLumber";
player addMagazine "PartWoodLumber";
player addMagazine "PartWoodLumber";
player addMagazine "PartWoodLumber";
player addMagazine "PartWoodLumber";
sleep 1;
titleText ["Craft 10xLumbers!! 12xWoodpiles was removed!", "PLAIN DOWN"];titleFadeOut 5;
};