/*                                DESCRIPTION
;$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
;$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
;$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

		Written By: Hellbent aka. CivReborn 
		Date Started: April 27th, 2017
		Date Of Last Edit: April 27th, 2017
		PasteBin Save: https://pastebin.com/ZvZGSv6J
		
		Description Of Program:
		
			This script is part of the Gui mini tutorial #21
		This script will help to show the viewer how to save the contents (Variables) of a Gui to a file
		and then load them back into the Gui using different methods to do so.
*/


;                                SETTINGS
;$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
;$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
;$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

#SingleInstance,Force
SetWorkingDir,%A_ScriptDir%
FileCreateDir, Temp File Folder For Gui Mini Tut 21
SetWorkingDir,Temp File Folder For Gui Mini Tut 21

;                               VARIABLE LIST
;$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
;$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
;$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
/*
RAD_Select_Bulk
RAD_Select_Delimited
EB_Bulk_Save
CB_Auto_Save
EB_DS_1
EB_DS_2
EB_DS_3
EB_DS_4
EB_DS_5
*/


;                                GUI LAYOUT
;$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
;$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
;$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

Gui, Color, Black,FFB1B1

Gui, Add, Radio,cAqua x40 y20 vRAD_Select_Bulk gSelect_Section,Bulk Save
Gui, Add, Radio,cAqua x+30 vRAD_Select_Delimited gSelect_Section,Delimited Save

;      Bulk Area
;-----------------------------------------------------------------------------
Gui, Add, Groupbox, x5 y40 w290 h215,
Gui, Add, Edit, xp+5 yp+10 w280 r10 Section Disabled vEB_Bulk_Save gBulk_Text_Edit,
Gui, Add, Checkbox,cWhite xs+30  Disabled Checked vCB_Auto_Save gSubmit_All,Auto Save
Gui, Add, Button, x+30 h13 w100 Disabled vButton1 gSave_Bulk_To_File,Press To Save
Gui, Add, Button, xs+6 yp+30 w130 h20 Disabled vButton2 gLoad_Bulk_File,Press To Load
Gui, Add, Button, x+10 w130 h20 Disabled vButton3 gUpdate_Edit,Press To Update 

;    Delimited Area
;----------------------------------------------------------------------------
Gui, Add, Groupbox, x5 y+10 w290 h180 ,
Gui, Add, Text,cLime xp+10 yp+20 w20 h20 Section Border Center,1: 
Gui, Add, Edit, x+20  w220 h20 Disabled vEB_DS_1 gSubmit_All,
Gui, Add, Text,cB400FF xs  w20 h20 Border Center,2: 
Gui, Add, Edit, x+20  w220 h20 Disabled vEB_DS_2 gSubmit_All,
Gui, Add, Text,cLime xs  w20 h20 Border Center,3: 
Gui, Add, Edit, x+20  w220 h20 Disabled vEB_DS_3 gSubmit_All,
Gui, Add, Text,cB400FF xs  w20 h20 Border Center,4: 
Gui, Add, Edit, x+20  w220 h20 Disabled vEB_DS_4 gSubmit_All,
Gui, Add, Text,cLime xs  w20 h20 Border Center,5: 
Gui, Add, Edit, x+20  w220 h20 Disabled vEB_DS_5 gSubmit_All,
Gui, Add, Button, xs y+10 w125 h20 Disabled vButton4 gSave_Delimited_To_File,Save To File
Gui, Add, Button, x+20 w125 h20 Disabled vButton5 gLoad_Delimited_File,Load From File

;-------------------------------------------------------------------------

Gui, Add, Button, x10 y+10 w135 h30 Disabled vButton6 gRun_Bulk_Text_File,Display Bulk.txt
Gui, Add, Button, x+10  w135 h30 Disabled vButton7 gRun_Delimited_File,Display Delimited.txt
Gui, Add, Button, x10 w280 h18 gReload_Gui,Reload

Gui,+AlwaysOnTop 
Gui, Show, w300 h500,

Gui, Submit, NoHide
return

;                                LABELS
;$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
;$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
;$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

GuiClose:
	ExitApp

Reload_Gui:	
    Reload
	return

Submit_All:	
    Gui, Submit, Nohide
	return

Select_Section:	
    Gui, Submit, NoHide
    If(RAD_Select_Bulk=1)
	{
	GuiControl, Disable, EB_DS_1
	GuiControl, Disable, EB_DS_2
	GuiControl, Disable, EB_DS_3
	GuiControl, Disable, EB_DS_4
	GuiControl, Disable, EB_DS_5
	GuiControl, Disable, Button4
	GuiControl, Disable, Button5
	GuiControl, Disable, Button7

	}
	Else if (RAD_Select_Delimited=1)
	{
	GuiControl, Enable, EB_DS_1
	GuiControl, Enable, EB_DS_2
	GuiControl, Enable, EB_DS_3
	GuiControl, Enable, EB_DS_4
	GuiControl, Enable, EB_DS_5
	GuiControl, Enable, Button4
	GuiControl, Enable, Button5
	GuiControl, Enable, Button7
	}
	return
	
	/*
RAD_Select_Bulk
RAD_Select_Delimited
EB_Bulk_Save
CB_Auto_Save
EB_DS_1
EB_DS_2
EB_DS_3
EB_DS_4
EB_DS_5
*/


Bulk_Text_Edit:	
	return

Save_Bulk_To_File:	
	return

Load_Bulk_File:	
	return
	
Update_Edit:	
	return
	
Save_Delimited_To_File:	
    FileDelete, Delimited.txt
	FileAppend,  % EB_DS_1 "*" EB_DS_2 "*" EB_DS_3 "*" EB_DS_4 "*" EB_DS_5, Delimited.txt           ; %
	return

Load_Delimited_File:
    FileRead, temp_File_Data, Delimited.txt
	Loop, Parse, temp_File_Data, *, &  ; & is ommited char
	   {
	   EB_DS_%A_Index% := A_LoopField
	   GuiCOntrol, ,EB_DS_%A_Index%, % EB_DS_%A_Index%                ;%
	   }
	return

Run_Bulk_Text_File:	
	return
	
Run_Delimited_File:	
    Run, Delimited.txt	
	return

;                                HOTKEYS
;$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
;$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
;$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

Esc::ExitApp