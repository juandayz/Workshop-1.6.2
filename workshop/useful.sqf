// use only whit DZE_permanentplot=true;


private ["_plotcheck","_cost","_coins","_playerPos","_nearRestr","_hastool","_hasitem","_removed","_abort","_reason","_distance","_isNear","_lockable","_isAllowedUnderGround","_offset","_classname","_zheightdirection","_zheightchanged","_rotate","_objectHelperPos","_objectHelperDir","_objHDiff","_position","_isOk","_dir","_vector","_cancel","_location2","_buildOffset","_location","_limit","_started","_finished","_animState","_isMedic","_proceed","_counter","_dis","_sfx","_combination_1_Display","_combination_1","_combination_2","_combination_3","_combination","_combinationDisplay","_combination_4","_num_removed","_tmpbuilt","_vUp","_classnametmp","_text","_ghost","_objectHelper","_location1","_object","_helperColor","_canDo","_pos","_onLadder","_vehicle","_inVehicle","_needNear","_canBuild"];

//Check if building already in progress, exit if so.
if (dayz_actionInProgress) exitWith {localize "str_epoch_player_40" call dayz_rollingMessages;};
dayz_actionInProgress = true;

_pos = [player] call FNC_GetPos;

_onLadder =    (getNumber (configFile >> "CfgMovesMaleSdr" >> "States" >> (animationState player) >> "onLadder")) == 1;

_vehicle = vehicle player;
_inVehicle = (_vehicle != player);


_nearpole = count nearestObjects [_pos, ["Plastic_Pole_EP1_DZ"], 50] < 1;


if (_nearpole)exitWith {
systemchat "CANNOT BUILD WITHOUT PLOT"; 
    dayz_actionInProgress = false;
    };
	
	
	
if !(_nearpole) then {
_canBuild = false;
_nearestPole = objNull;
_ownerID = 0;
_friendlies = [];


_plotcheck = [player, false] call FNC_find_plots;
_distance = DZE_PlotPole select 0;



_nearestPole = _plotcheck select 2;




	_ownerID = _nearestPole getVariable["CharacterID","0"];
	if (dayz_characterID == _ownerID) then {
		_canBuild = true;
	} else {
		if (DZE_permanentPlot) then {
			_buildcheck = [player, _nearestPole] call FNC_check_access;
			_isowner = _buildcheck select 0;
			_isfriendly = ((_buildcheck select 1) or (_buildcheck select 3));
			if (_isowner || _isfriendly) then {
				_canBuild = true;
			};
		} else {
			_friendlies	= player getVariable ["friendlyTo",[]];
			if (_ownerID in _friendlies) then {
				_canBuild = true;
			};
		};
	};
};

if (!_canBuild) exitWith {systemchat "not your pole";dayz_actionInProgress = false;};	
	
		
	
	

DZE_Q = false;
DZE_Z = false;

DZE_Q_alt = false;
DZE_Z_alt = false;

DZE_Q_ctrl = false;
DZE_Z_ctrl = false;

DZE_5 = false;
DZE_4 = false;
DZE_6 = false;

DZE_F = false;

DZE_cancelBuilding = false;

DZE_updateVec = false;
DZE_memDir = 0;
DZE_memForBack = 0;
DZE_memLeftRight = 0;

call gear_ui_init;
closeDialog 1;

if (dayz_isSwimming) exitWith {dayz_actionInProgress = false; localize "str_player_26" call dayz_rollingMessages;};
if (_inVehicle) exitWith {dayz_actionInProgress = false; localize "str_epoch_player_42" call dayz_rollingMessages;};
if (_onLadder) exitWith {dayz_actionInProgress = false; localize "str_player_21" call dayz_rollingMessages;};
if (player getVariable["combattimeout",0] >= diag_tickTime) exitWith {dayz_actionInProgress = false; localize "str_epoch_player_43" call dayz_rollingMessages;};



//////////////////////////////PUT YOUR OBJET ID BELLOW
_classname =  _this select 0;






if (_classname isKindOf "MAP_Shed_W01") then {

_nearRestr = count nearestObjects [_pos, ["MAP_Shed_W01"], 45] > 0;

}else{
if (_classname isKindOf "MAP_Dkamna_bila") then {

_nearRestr = count nearestObjects [_pos, ["MAP_Dkamna_bila"], 45] > 0;

}else{
if (_classname isKindOf "Land_Misc_Well_L_EP1") then {

_nearRestr = count nearestObjects [_pos, ["Land_Misc_Well_L_EP1"], 45] > 0;
 
}else{
if (_classname isKindOf "MAP_P_Stavebni_kozy") then {

_nearRestr = count nearestObjects [_pos, ["MAP_P_Stavebni_kozy"], 45] > 0;

}else{
if (_classname isKindOf "MAP_office_table_a") then {

_nearRestr = count nearestObjects [_pos, ["MAP_office_table_a"], 45] > 0; 
};
};
};
};
};

if (_nearRestr) exitWith {
systemchat "CANNOT BUILD ANOTHER BUILDABLE HERE"; 
    dayz_actionInProgress = false;
    };

//////////////////////////////////////////////////##########MATERIALS NEEDED SECTION

if (_classname isKindOf "MAP_Shed_W01") then {

_hasitem = [["PartWoodLumber",4],["PartWoodPlywood",4]] call player_checkItems;


}else{
if (_classname isKindOf "MAP_Dkamna_bila") then {

_hasitem = [["PartGeneric",4], "ItemPole","PartEngine"] call player_checkItems;

}else{
if (_classname isKindOf "Land_Misc_Well_L_EP1") then {

_hasitem = [["CinderBlocks",2], "PartWoodPlywood"] call player_checkItems;
 
}else{
if (_classname isKindOf "MAP_P_Stavebni_kozy") then {

_hasitem = [["PartWoodLumber",4], "PartWoodPlywood"] call player_checkItems;

}else{
if (_classname isKindOf "MAP_office_table_a") then {

_hasitem = [["PartWoodLumber",4], "PartWoodPlywood"] call player_checkItems;
};
};
};
};
};


	

		//////////////////////////////////////////////////##########MATERIALS NEEDED SECTION

_hastools = ["ItemToolbox"] call player_hasTools;


if !(_hasitem) exitWith {dayz_actionInProgress = false;};
if !(_hastools) exitWith {dayz_actionInProgress = false;};





///////////////////////////////////////////////    
_classnametmp = _classname;
_text =         getText (configFile >> "CfgVehicles" >> _classname >> "displayName");
_ghost = getText (configFile >> "CfgVehicles" >> _classname >> "ghostpreview");
    

    _lockable = 0; //default define if lockable not found in config file below
    if(isNumber (configFile >> "CfgVehicles" >> _classname >> "lockable")) then { //find out if item is lockable object
        _lockable = getNumber(configFile >> "CfgVehicles" >> _classname >> "lockable"); // 2=lockbox, 3=combolock, 4=safe
    };

    _isAllowedUnderGround = 1; //check if allowed to build under terrain
    if(isNumber (configFile >> "CfgVehicles" >> _classname >> "nounderground")) then {
        _isAllowedUnderGround = getNumber(configFile >> "CfgVehicles" >> _classname >> "nounderground");
    };

_offset =     getArray (configFile >> "CfgVehicles" >> _classname >> "offset");

if((count _offset) <= 0) then {
    

_offset = [0,2,1];

};

  

    _objectHelper = objNull;
    _isOk = true;
    _location1 = [player] call FNC_GetPos; // get inital players position
    _dir = getDir player; //required to pass direction when building

    // if ghost preview available use that instead
    if (_ghost != "") then {
        _classname = _ghost;
    };

    _object = createVehicle [_classname, [0,0,0], [], 0, "CAN_COLLIDE"]; //object preview, not an actual object that will be built

    

    _objectHelper = "Sign_sphere10cm_EP1" createVehicle [0,0,0];
    _helperColor = "#(argb,8,8,3)color(0,0,0,0,ca)";
    _objectHelper setobjecttexture [0,_helperColor];
    _objectHelper attachTo [player,_offset];
    _object attachTo [_objectHelper,[0,0,0]];

    if (isClass (configFile >> "SnapBuilding" >> _classname)) then {    
        ["","","",["Init",_object,_classname,_objectHelper]] spawn snap_build;
    };

    
        ["","","",["Init","Init",0]] spawn build_vectors;
    

    _objHDiff = 0;    
    _cancel = false;
    _reason = "";
    
    helperDetach = false;
    _canDo = (!r_drag_sqf and !r_player_unconscious);
    _position = [_objectHelper] call FNC_GetPos;

    while {_isOk} do {

        _zheightchanged = false;
        _zheightdirection = "";
        _rotate = false;

        if (DZE_Q) then {
            DZE_Q = false;
            _zheightdirection = "up";
            _zheightchanged = true;
        };
        if (DZE_Z) then {
            DZE_Z = false;
            _zheightdirection = "down";
            _zheightchanged = true;
        };
        if (DZE_Q_alt) then {
            DZE_Q_alt = false;
            _zheightdirection = "up_alt";
            _zheightchanged = true;
        };
        if (DZE_Z_alt) then {
            DZE_Z_alt = false;
            _zheightdirection = "down_alt";
            _zheightchanged = true;
        };
        if (DZE_Q_ctrl) then {
            DZE_Q_ctrl = false;
            _zheightdirection = "up_ctrl";
            _zheightchanged = true;
        };
        if (DZE_Z_ctrl) then {
            DZE_Z_ctrl = false;
            _zheightdirection = "down_ctrl";
            _zheightchanged = true;
        };
        if (DZE_4) then {
            _rotate = true;
            DZE_4 = false;
            if(DZE_dirWithDegrees) then{
                DZE_memDir = DZE_memDir - DZE_curDegree;
            }else{
                DZE_memDir = DZE_memDir - 45;
            };
        };
        if (DZE_6) then {
            _rotate = true;
            DZE_6 = false;
            if(DZE_dirWithDegrees) then{
                DZE_memDir = DZE_memDir + DZE_curDegree;
            }else{
                DZE_memDir = DZE_memDir + 45;
            };
        };
        
        if(DZE_updateVec) then{
            [_objectHelper,[DZE_memForBack,DZE_memLeftRight,DZE_memDir]] call fnc_SetPitchBankYaw;
            DZE_updateVec = false;
        };
        
        if (DZE_F and _canDo) then {
            if (helperDetach) then {
                _objectHelper attachTo [player];
                DZE_memDir = DZE_memDir-(getDir player);
                helperDetach = false;
                [_objectHelper,[DZE_memForBack,DZE_memLeftRight,DZE_memDir]] call fnc_SetPitchBankYaw;
            } else {        
                _objectHelperPos = getPosATL _objectHelper;
                detach _objectHelper;            
                DZE_memDir = getDir _objectHelper;
                [_objectHelper,[DZE_memForBack,DZE_memLeftRight,DZE_memDir]] call fnc_SetPitchBankYaw;
                _objectHelper setPosATL _objectHelperPos;
                _objectHelper setVelocity [0,0,0]; //fix sliding glitch
                helperDetach = true;
            };
            DZE_F = false;
        };

        if(_rotate) then {
            [_objectHelper,[DZE_memForBack,DZE_memLeftRight,DZE_memDir]] call fnc_SetPitchBankYaw;
        };

        if(_zheightchanged) then {
            if (!helperDetach) then {
            detach _objectHelper;
            _objectHelperDir = getDir _objectHelper;
            };

            _position = [_objectHelper] call FNC_GetPos;

            if(_zheightdirection == "up") then {
                _position set [2,((_position select 2)+0.1)];
                _objHDiff = _objHDiff + 0.1;
            };
            if(_zheightdirection == "down") then {
                _position set [2,((_position select 2)-0.1)];
                _objHDiff = _objHDiff - 0.1;
            };

            if(_zheightdirection == "up_alt") then {
                _position set [2,((_position select 2)+1)];
                _objHDiff = _objHDiff + 1;
            };
            if(_zheightdirection == "down_alt") then {
                _position set [2,((_position select 2)-1)];
                _objHDiff = _objHDiff - 1;
            };

            if(_zheightdirection == "up_ctrl") then {
                _position set [2,((_position select 2)+0.01)];
                _objHDiff = _objHDiff + 0.01;
            };
            if(_zheightdirection == "down_ctrl") then {
                _position set [2,((_position select 2)-0.01)];
                _objHDiff = _objHDiff - 0.01;
            };

            if((_isAllowedUnderGround == 0) && ((_position select 2) < 0)) then {
                _position set [2,0];
            };

            if (surfaceIsWater _position) then {
                _objectHelper setPosASL _position;
            } else {
                _objectHelper setPosATL _position;
            };

            if (!helperDetach) then {
            _objectHelper attachTo [player];
            };
            [_objectHelper,[DZE_memForBack,DZE_memLeftRight,DZE_memDir]] call fnc_SetPitchBankYaw;
        };

        uiSleep 0.5;

        _location2 = [player] call FNC_GetPos;
        _objectHelperPos = [_objectHelper] call FNC_GetPos;
        
        if(DZE_5) exitWith {
            _isOk = false;
            _position = [_object] call FNC_GetPos;
            detach _object;
            _dir = getDir _object;
            _vector = [(vectorDir _object),(vectorUp _object)];    
            deleteVehicle _object;
            detach _objectHelper;
            deleteVehicle _objectHelper;
        };

        if(_location1 distance _location2 > 25) exitWith {
            _isOk = false;
            _cancel = true;
            _reason = format[localize "STR_EPOCH_BUILD_FAIL_MOVED",DZE_buildMaxMoveDistance];
            detach _object;
            deleteVehicle _object;
            detach _objectHelper;
            deleteVehicle _objectHelper;
        };
        
        if(_location1 distance _objectHelperPos > 25) exitWith {
            _isOk = false;
            _cancel = true;
            _reason = format[localize "STR_EPOCH_BUILD_FAIL_TOO_FAR",DZE_buildMaxMoveDistance];
            detach _object;
            deleteVehicle _object;
            detach _objectHelper;
            deleteVehicle _objectHelper;
        };

        if(abs(_objHDiff) > DZE_buildMaxHeightDistance) exitWith {
            _isOk = false;
            _cancel = true;
            _reason = format[localize "STR_EPOCH_BUILD_FAIL_HEIGHT",DZE_buildMaxHeightDistance];
            detach _object;
            deleteVehicle _object;
            detach _objectHelper;
            deleteVehicle _objectHelper;
        };
        
		if (DZE_BuildHeightLimit > 0 && {_position select 2 > DZE_BuildHeightLimit}) exitWith {
			_isOk = false;
			_cancel = true;
			_reason = format[localize "STR_EPOCH_PLAYER_168",DZE_BuildHeightLimit];
			detach _object;
			deleteVehicle _object;
			if (_VectorWorkAround) then {
				detach _object2;
				deleteVehicle _object2;
			};
			detach _objectHelper;
			deleteVehicle _objectHelper;
		};
		
		
        if (player getVariable["combattimeout",0] >= diag_tickTime) exitWith {
            _isOk = false;
            _cancel = true;
            _reason = localize "str_epoch_player_43";
            detach _object;
            deleteVehicle _object;
            detach _objectHelper;
            deleteVehicle _objectHelper;
        };

        if (DZE_cancelBuilding) exitWith {
            _isOk = false;
            _cancel = true;
            _reason = localize "STR_EPOCH_PLAYER_46";
            detach _object;
            deleteVehicle _object;
            detach _objectHelper;
            deleteVehicle _objectHelper;
        };
    };
    
    _isOk = true;
    _proceed = false;
    _counter = 0;
    _location = [0,0,0];

    //No building on roads unless toggled
    if (!DZE_BuildOnRoads) then {
        if (isOnRoad _position) then { _cancel = true; _reason = localize "STR_EPOCH_BUILD_FAIL_ROAD"; };
    };

    // No building in trader zones
    if(!canbuild) then { _cancel = true; _reason = format[localize "STR_EPOCH_PLAYER_136",localize "STR_EPOCH_TRADER"]; };

    if(!_cancel) then {

        _classname = _classnametmp;

        // Start Build
        _tmpbuilt = createVehicle [_classname, _location, [], 0, "CAN_COLLIDE"]; //create actual object that will be published to database

        _tmpbuilt setdir _dir; //set direction inherited from passed args from control
        _tmpbuilt setVariable["memDir",_dir,true];

_pos = [player] call FNC_GetPos;
_nearpole = count nearestObjects [_pos, ["Plastic_Pole_EP1_DZ"], 20] < 1;
if (_nearpole)exitWith {
systemchat "CANNOT BUILD WITHOUT PLOT"; 
    dayz_actionInProgress = false;
    };
		
        // Get position based on object
        _location = _position;

        if((_isAllowedUnderGround == 0) && ((_location select 2) < 0)) then { //check Z axis if not allowed to build underground
            _location set [2,0]; //reset Z axis to zero (above terrain)
        };
        
        _tmpbuilt setVectorDirAndUp _vector;
        
        _buildOffset = [0,0,0];
        _vUp = _vector select 1;
        switch (_classname) do {
            case "MetalFloor_DZ": { _buildOffset = [(_vUp select 0) * .148, (_vUp select 1) * .148,0]; };
        };
        
        _location = [
            (_location select 0) - (_buildOffset select 0),
            (_location select 1) - (_buildOffset select 1),
            (_location select 2) - (_buildOffset select 2)
        ];
    
        if (surfaceIsWater _location) then {
            _tmpbuilt setPosASL _location;
            _location = ASLtoATL _location; //Database uses ATL
        } else {
            _tmpbuilt setPosATL _location;
        };

        format[localize "str_epoch_player_138",_text] call dayz_rollingMessages;

        

player playActionNow "Medic";
[player,"repair",0,false,10] call dayz_zombieSpeak;
[player,10,true,(getPosATL player)] spawn player_alertZombies;
sleep 3;

		//////////////////////////////////////////////////##########REMOVE OBJECTS SECTION


if (_classname isKindOf "MAP_Shed_W01") then {

player removeMagazine "PartWoodLumber";
player removeMagazine "PartWoodLumber";
player removeMagazine "PartWoodLumber";
player removeMagazine "PartWoodLumber";

player removeMagazine "PartWoodPlywood";
player removeMagazine "PartWoodPlywood";
player removeMagazine "PartWoodPlywood";
player removeMagazine "PartWoodPlywood";

}else{
if (_classname isKindOf "MAP_Dkamna_bila") then {
player removeMagazine "PartGeneric";
player removeMagazine "PartGeneric";
player removeMagazine "PartGeneric";
player removeMagazine "PartGeneric";
player removeMagazine "ItemPole";
player removeMagazine "PartEngine";


}else{
if (_classname isKindOf "Land_Misc_Well_L_EP1") then {
player removeMagazine "CinderBlocks";
player removeMagazine "CinderBlocks";
player removeMagazine "PartWoodPlywood";
}else{
if (_classname isKindOf "MAP_P_Stavebni_kozy") then {
player removeMagazine "PartWoodLumber";
player removeMagazine "PartWoodLumber";
player removeMagazine "PartWoodLumber";
player removeMagazine "PartWoodLumber";
player removeMagazine "PartWoodPlywood"; 

}else{
if (_classname isKindOf "MAP_office_table_a") then {
player removeMagazine "PartWoodLumber";
player removeMagazine "PartWoodLumber";
player removeMagazine "PartWoodLumber";
player removeMagazine "PartWoodLumber";
player removeMagazine "PartWoodPlywood";  

};
};
};
};
};
		
		
		










		//////////////////////////////////////////////////##########REMOVE OBJECTS SECTION



////////////////////////////////////////////////////////////////////////////////        
        _limit = 3; //times it takes to build by default

        if (DZE_StaticConstructionCount > 0) then { //if count is manually overridden inside init.sqf, use that instead, else use limits configured in config files
            _limit = DZE_StaticConstructionCount;
        }
        else {
            if (isNumber (configFile >> "CfgVehicles" >> _classname >> "constructioncount")) then {
                _limit = getNumber(configFile >> "CfgVehicles" >> _classname >> "constructioncount");
            };
        };


        
                

                _tmpbuilt setVariable ["OEMPos",_location,true]; //store original location as a variable

                 //if not lockable item
                    
                    _tmpbuilt setVariable ["CharacterID",dayz_characterID,true];
                    
                        if (DZE_permanentPlot) then {
						
                            _tmpbuilt setVariable ["ownerPUID",dayz_playerUID,true];
                           
                                _friendsArr = [[dayz_playerUID,toArray (name player)]];
                                _tmpbuilt setVariable ["plotfriends", _friendsArr, true];
                                PVDZ_obj_Publish = [dayz_characterID,_tmpbuilt,[_dir,_location,dayz_playerUID,_vector],_friendsArr,player,dayz_authKey];
                                publicVariableServer "PVDZ_obj_Publish";
                           
                    };
                
            } else { //if magazine was not removed, cancel publish
                deleteVehicle _tmpbuilt;
                localize "str_epoch_player_46" call dayz_rollingMessages;
            };

    	

//by juandayz writed with base on modular_build.sqf

dayz_actionInProgress = false;