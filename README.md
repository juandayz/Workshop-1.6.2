# Workshop-1.6.2

Allow players in his bases to: Breed Animals. Craft Mounted weapons. Craft a carpenter bench. A clothes maker table. Survillange Systems with cams (credits to makas for this one). A kitchen to cook better, A water source.

**Install:**

1-Drop workshop folder into your scripts folder.

2-A-Open your custom variables.sqf and paste in somewhere:

```ruby
workshop_obj = ["MAP_plot_green_draty","SmallTV","Loudspeaker","DSHKM_Gue","M2StaticMG","SearchLight_RUS","MAP_Shed_W01","MAP_Dkamna_bila","Land_Misc_Well_L_EP1","MAP_P_Stavebni_kozy","MAP_office_table_a"];

DayZ_SafeObjects = workshop_obj + DayZ_SafeObjects;
DZE_maintainClasses = DZE_maintainClasses + workshop_obj;
DZE_safeVehicle = ["ParachuteWest","ParachuteC","M2StaticMG","SearchLight_RUS","DSHKM_Gue"];
```
2-B-Paste: ```s_player_managework = -1;``` with the rest of actions.

3.A.Open your custom fn_selfactions.sqf
Find:
```if (_restrict || _isModular || _isModularDoor || _isGenerator || _typeOfCursorTarget in DZE_isDestroyableStorage ||  _typeOfCursorTarget in workshop_obj) then {```

Replace by:

```ruby
if (_restrict || _isModular || _isModularDoor || _isGenerator || _typeOfCursorTarget in DZE_isDestroyableStorage ||  _typeOfCursorTarget in workshop_obj) then {
```

B-Find:
```
	if (_typeOfCursorTarget == "Plastic_Pole_EP1_DZ" && {speed player <= 1}) then {
		_hasAccess = [player, _cursorTarget] call FNC_check_access;
		_allowed = ((_hasAccess select 0) or (_hasAccess select 2) or (_hasAccess select 3) or (_hasAccess select 4));
		if (DZE_permanentPlot) then {
			if (s_player_plotManagement < 0 && _allowed) then {
				s_player_plotManagement = player addAction [format["<t color='#b3e6ff'>%1</t>",localize "STR_EPOCH_ACTIONS_MANAGEPLOT"], "\z\addons\dayz_code\actions\plotManagement\initPlotManagement.sqf", [], 5, false];
			};
		} else {
			if (s_player_maintain_area < 0) then {
				s_player_maintain_area = player addAction [format["<t color='#ff0000'>%1</t>",localize "STR_EPOCH_ACTIONS_MAINTAREA"], "\z\addons\dayz_code\actions\maintain_area.sqf", "maintain", 5, false];
				s_player_maintain_area_force = player addAction [format["<t color='#ff0000'>%1</t>",localize "STR_EPOCH_ACTIONS_FORCE_MAINTAREA"], "\z\addons\dayz_code\actions\maintain_area.sqf", "force", 5, false];
				s_player_maintain_area_preview = player addAction [format["<t color='#ff0000'>%1</t>",localize "STR_EPOCH_ACTIONS_MAINTPREV"], "\z\addons\dayz_code\actions\maintain_area.sqf", "preview", 5, false];
			};
		};
		if (s_player_plot_boundary < 0 && (_allowed or (_hasAccess select 1))) then {
			s_player_plot_boundary = player addAction [localize "STR_EPOCH_PLOTMANAGEMENT_SHOW_BOUNDARY", "\z\addons\dayz_code\actions\plotManagement\plotToggleMarkers.sqf", "", 1, false];
		};		        
	} else {
		player removeAction s_player_plotManagement;
		s_player_plotManagement = -1;
		player removeAction s_player_maintain_area;
		s_player_maintain_area = -1;
		player removeAction s_player_maintain_area_force;
		s_player_maintain_area_force = -1;
		player removeAction s_player_maintain_area_preview;
		s_player_maintain_area_preview = -1;
		player removeAction s_player_plot_boundary;
		s_player_plot_boundary = -1;				
	};
```
Replace the whole block by:

```ruby
	if (_typeOfCursorTarget == "Plastic_Pole_EP1_DZ" && {speed player <= 1}) then {
		_hasAccess = [player, _cursorTarget] call FNC_check_access;
		_allowed = ((_hasAccess select 0) or (_hasAccess select 2) or (_hasAccess select 3) or (_hasAccess select 4));
		if (DZE_permanentPlot) then {
			if (s_player_plotManagement < 0 && _allowed) then {
				s_player_plotManagement = player addAction [format["<t color='#b3e6ff'>%1</t>",localize "STR_EPOCH_ACTIONS_MANAGEPLOT"], "\z\addons\dayz_code\actions\plotManagement\initPlotManagement.sqf", [], 5, false];
			};
		} else {
			if (s_player_maintain_area < 0) then {
				s_player_maintain_area = player addAction [format["<t color='#ff0000'>%1</t>",localize "STR_EPOCH_ACTIONS_MAINTAREA"], "\z\addons\dayz_code\actions\maintain_area.sqf", "maintain", 5, false];
				s_player_maintain_area_force = player addAction [format["<t color='#ff0000'>%1</t>",localize "STR_EPOCH_ACTIONS_FORCE_MAINTAREA"], "\z\addons\dayz_code\actions\maintain_area.sqf", "force", 5, false];
				s_player_maintain_area_preview = player addAction [format["<t color='#ff0000'>%1</t>",localize "STR_EPOCH_ACTIONS_MAINTPREV"], "\z\addons\dayz_code\actions\maintain_area.sqf", "preview", 5, false];
			};
		};
		if (s_player_plot_boundary < 0 && (_allowed or (_hasAccess select 1))) then {
			s_player_plot_boundary = player addAction [localize "STR_EPOCH_PLOTMANAGEMENT_SHOW_BOUNDARY", "\z\addons\dayz_code\actions\plotManagement\plotToggleMarkers.sqf", "", 1, false];
		};
		
		if (s_player_managework < 0) then {
        s_player_managework = player addAction ["<t color='#66CCFF'>MANAGE WORKSHOP</t>", "scripts\workshop\workshopmenu.sqf", [], 5, false];
        };
        
        
      
	} else {
		player removeAction s_player_plotManagement;
		s_player_plotManagement = -1;
		player removeAction s_player_maintain_area;
		s_player_maintain_area = -1;
		player removeAction s_player_maintain_area_force;
		s_player_maintain_area_force = -1;
		player removeAction s_player_maintain_area_preview;
		s_player_maintain_area_preview = -1;
		player removeAction s_player_plot_boundary;
		s_player_plot_boundary = -1;		
		player removeAction s_player_managework;
        s_player_managework = -1;
		
	};
  ```
  
  C-Find:
  ```
  player removeAction s_player_fuelauto2;
	s_player_fuelauto2 = -1;
	player removeAction s_player_manageDoor;
	s_player_manageDoor = -1;
  ```
  Below paste:
  ```ruby
  player removeAction s_player_managework;
  s_player_managework = -1;
  ```
  
  4-Open your server_monitor.sqf
  
  A-Find:
  ```_isPlot = _type == "Plastic_Pole_EP1_DZ";```
  Below Paste:
  ```ruby
  _workshop_obj = _type in workshop_obj;
  ```
  B-Find:
  ```if((count _inventory > 0) && !_isPlot && !_doorLocked) then { ```
  Replace by:
  ```ruby
  if((count _inventory > 0) && !_isPlot && !_doorLocked  && !_workshop_obj) then {
  ```
  
  5:***INFISTAR***
  open your AHConfig.sqf
  
  into: _cMenu =[.............]; paste:
  
```
  ,"#USER:surveillance","#USER:STATICS","#USER:USEFUL","#USER:ACTIONS","#USER:workshopMenu"
```

into: _dayzActions =[......];
paste:
```
"s_player_managework"
```

  
