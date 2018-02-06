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
Paste: ```ruby s_player_managework = -1;``` with the rest of actions.

3.Open your custom fn_selfactions.sqf

