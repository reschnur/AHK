

GUI, Font, s10 bold

Gui, Add, ListView, x10 y56 w278 h210 +Center grid checked , Report Type|Date

recno = 0

Loop,Read,G:\Games\Minecraft\Mods & Tools\2-AHK Scripts\Minecraft RES Tool Suite\world-names-desktop.txt
{
    recno += 1
	
	; skip first record - comment
    if recno = 1
	   continue
	   
	StringSplit, var_,A_LoopReadLine,~;

	LV_Add("",var_1, var_2) ;,var_2,var_3,var_4,var_5,var_6) ;.... you will need to add as many as you have columns (up to 253 parameters possible)
    LV_ModifyCol(1, "AutoHdr") 
	LV_ModifyCol(2, "AutoHdr") 
	
	WorldPath%recno% = %var_3%
	MsgBox, 0, %Script_Name%, World Path: WorldPath%recno%
}

Gui, Add, Text, r2 x420 y6 w450, Enter your notes in the box below and then double click the appropriate world name to add it that world's file.
Gui, Add, Edit,  x420 y48 w450 r16 h160 vnotetext, default note text

Gui, Font, s10 bold
Gui, Add, Text, r2 x10 y336 w460, Click a buttons below to open the related file. 

Gui, Add, Button, x10 y310 w90 h22 gaddnote, Add Note
Gui, Add, Button, x104 y310 w90 h22 gopennotes, Open Notes
Gui, Add, Button, x198 y310 w90 h22 gmovescreenshots, Move Shots
Gui, Add, Button, x198 y338 w90 h22 gopenscreenshots, Open Shots
Gui, Add, Button, x292 y338 w90 h22 gopenworlds, Open Worlds

gui, show

Return


LV_GetChecked() 
{
    while rowNumber := LV_GetNext(rowNumber, "Checked")
        checkedRowList .= rowNumber . "`n"       ; .= is concatenate
    
	return RTrim(checkedRowList)
}

Return

addnote:

opennotes:

; This msgbox executes the funcitno to get the reults. it is more effiecint than separate lines.
msgbox, 49, Rows Checked, % LV_GetChecked()   ; this % even though in a comment offsets the one on this line so the rest of the code colors correctly

movescreenshots:

openscreenshots:

openworlds:
