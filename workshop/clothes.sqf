private ["_clothes","_inventory","_hastool","_hasitems","_playerPos","_nearRestr","_removed","_brokeChance"];

_inventory = items player;
_hastool = "ItemToolbox" in _inventory;
_hasitems = [["ItemTrashRazor",1],["ItemBandage",4]] call player_checkItems;
_playerPos = getPosATL player;
_nearRestr = count nearestObjects [_playerPos, ["MAP_office_table_a"], 15] > 0;
_brokeChance = round(random 10);

if !(_nearRestr) exitWith {
cutText [format["Needs be near of DressMaker"], "PLAIN DOWN"];  
	};
	
if !(_hastool) exitWith {
	cutText [format["Must be equiped with 1x toolbox in your toolbet."], "PLAIN DOWN"];
};

if !(_hasitems) exitWith {
	cutText [format["Needs 1xRazor & 4xBandages."], "PLAIN DOWN"];
};

if (_nearRestr && _hastool && _hasitems) then {
player playActionNow "Medic";
[player,"repair",0,false,10] call dayz_zombieSpeak;
[player,10,true,(getPosATL player)] spawn player_alertZombies;
sleep 5;
if (_brokeChance < 2) then {
	player removeMagazine "ItemTrashRazor";
		cutText [format["%1, you broke your Razor",name player], "PLAIN DOWN"];
	};

player removeMagazine "ItemBandage";
player removeMagazine "ItemBandage";
player removeMagazine "ItemBandage";
player removeMagazine "ItemBandage";
_clothes = ["Skin_GUE_Soldier_CO_DZ","Skin_GUE_Soldier_Crew_DZ","Skin_TK_INS_Soldier_EP1_DZ","Skin_TK_INS_Warlord_EP1_DZ","Skin_TK_INS_Soldier_AR_EP1_DZ"] call BIS_fnc_selectRandom;

player addMagazine _clothes;
sleep 1;
titleText ["Craft your own clothes!!!", "PLAIN DOWN"];titleFadeOut 5;
};




	