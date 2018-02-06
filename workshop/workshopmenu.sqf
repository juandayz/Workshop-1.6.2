_statics = '["%1"] execVM "scripts\workshop\statics.sqf"';
_useful = '["%1"] execVM "scripts\workshop\useful.sqf"';
_survillange = '["%1"] execVM "scripts\workshop\cctv\craft.sqf"';

workshopMenu =
[
    ["",true],
 
       
        ["WORKSHOP", [], "", -5, [["expression", ""]], "1", "0"],
		["SURVILLANGE SYSTEM>>",[],"#USER:surveillance", -5,[["expression",""]],"1","1"],
        ["STATICS>>", [], "#USER:STATICS", -5, [["expression", ""]], "1", "1"],
        ["USEFUL>>", [], "#USER:USEFUL", -5, [["expression", ""]], "1", "1"],		
		["ACTIONS>>", [], "#USER:ACTIONS", -5, [["expression", ""]], "1", "1"],
        ["", [], "", -5, [["expression", ""]], "1", "0"],      
        ["Exit", [13], "", -3, [["expression", ""]], "1", "1"]
];

STATICS =
[
    ["",true],
    [">STATICS<", [], "", -5, [["expression", ""]], "1", "0"],
    ["DSHKM", [], "", -5, [["expression", format[_statics,"DSHKM_Gue"]]], "1", "1"],
    ["M2", [], "", -5, [["expression", format[_statics,"M2StaticMG"]]], "1", "1"],
    ["SearchLight", [], "", -5, [["expression", format[_statics,"SearchLight_RUS"]]], "1", "1"],
  
 
            ["", [], "", -5, [["expression", ""]], "1", "0"],
            ["Exit", [13], "", -3, [["expression", ""]], "1", "1"]
]; 

USEFUL =
[
    ["",true],
    [">USEFUL<", [], "", -5, [["expression", ""]], "1", "0"],
    ["BreedHouse", [], "", -5, [["expression", format[_useful,"MAP_Shed_W01"]]], "1", "1"],
    ["Kitchen", [], "", -5, [["expression", format[_useful,"MAP_Dkamna_bila"]]], "1", "1"],
    ["WaterSource", [], "", -5, [["expression", format[_useful,"Land_Misc_Well_L_EP1"]]], "1", "1"],
	["CarpenterBench", [], "", -5, [["expression", format[_useful,"MAP_P_Stavebni_kozy"]]], "1", "1"],
	["DressTable", [], "", -5, [["expression", format[_useful,"MAP_office_table_a"]]], "1", "1"],
  
 
            ["", [], "", -5, [["expression", ""]], "1", "0"],
            ["Exit", [13], "", -3, [["expression", ""]], "1", "1"]
]; 

ACTIONS =
[
    ["",true],
    [">ACTIONS<", [], "", -5, [["expression", ""]], "1", "0"],
    ["Cook", [],  "", -5, [["expression",     "[] execVM 'scripts\workshop\cook.sqf'"]], "1", "1"],
	["Breeding", [],  "", -5, [["expression",     "[] execVM 'scripts\workshop\breeding.sqf'"]], "1", "1"],
	["CraftWoodLumbers", [],  "", -5, [["expression",     "[] execVM 'scripts\workshop\craftwoodlumbers.sqf'"]], "1", "1"],
	["CraftPlywoods", [],  "", -5, [["expression",     "[] execVM 'scripts\workshop\craftplywood.sqf'"]], "1", "1"],
	["CraftClothes", [],  "", -5, [["expression",     "[] execVM 'scripts\workshop\clothes.sqf'"]], "1", "1"],
 
            ["", [], "", -5, [["expression", ""]], "1", "0"],
            ["Exit", [13], "", -3, [["expression", ""]], "1", "1"]
]; 

surveillance =
[
    ["",true],
    [">surveillance<", [], "", -5, [["expression", ""]], "1", "0"],
    ["REMOTE VISOR", [], "", -5, [["expression", format[_survillange,"SmallTV"]]], "1", "1"],
    ["CAMERA", [], "", -5, [["expression", format[_survillange,"Loudspeaker"]]], "1", "1"],
  
 
            ["", [], "", -5, [["expression", ""]], "1", "0"],
            ["Exit", [13], "", -3, [["expression", ""]], "1", "1"]
];

showCommandingMenu "#USER:workshopMenu";
 