; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Build the GUI
; This version is a more generic version than the base one which is specific to Minecraft
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

ToolsFolder = G:\Games\Minecraft\Mods & Tools\2-AHK Scripts\Minecraft RES Tool Suite
worldnamesfile = %ToolsFolder%\world-names-desktop.txt


GUI, Font, s10 bold

Gui, Add, ListView, r12 backgroundteal cwhite x10 y50 w400 +Center grid checked , World Name|Profile Name|World Path

recno = 0

Loop, Read, %WorldNamesFile% 
{
    recno += 1
	
	; skip first record - comment
    if recno = 1
	   continue
	   
	StringSplit, var_,A_LoopReadLine,~;
	
    ;MsgBox, 0, %Script_Name%, 1: %var_1%`n2: %var_2%`n3: %var_3%

	LV_Add("",var_1, var_2, var_3)        ; Add as many var_x as you have columns (up to 253 parameters possible)
    LV_ModifyCol(1, "AutoHdr") 
	LV_ModifyCol(2, "AutoHdr")            ; Autohdr allows dynamic header width
	LV_ModifyCol(3, "0")                  ; 0 is the column width. 0 means hide the column. it is still avaialbe for processing.
}

Gui, Add, Text, r2 x10 y6 w600, Select your world (only the first checked box will process) then enter your notes in the box. Click Add Note to add the note to the appropriate world's file.

Gui, Font, s10 bold

Gui, Add, Button, x10 y330 w100 h25 gProcessListview, Process

gui, show, , Listview Test

Return


; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Process GUI
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

; Default actions

GuiEscape:
Gui, Destroy
exitapp

GuiClose:
gui, Destroy
exitapp

; Process

ProcessListView:

; This version eliminates the need for the counting routine

gui, submit
   
RowNumber = 0                                      ; This causes the first iteration to start at the top of the list.
RowCount  = 0

Loop
{
    RowNumber := LV_GetNext(RowNumber, "Checked")  ; Resume search at row after row found by previous iteration.

    if not RowNumber                               ; The above returned zero, no more selected rows.
	   {
	   if RowCount = 0
	      msgbox, 0, , No rows selected.
	   else
		  msgbox, 0, , End of rows
       break
	   }  
    else
       {    
	   LV_GetText(WorldPath, RowNumber, 3)            ;
	
       splitpath, WorldPath, , ProfileSavesPath       ; strip world name from path
       splitpath, ProfileSavesPath, , ProfilePath     ; Strip saves literal from path
	
       ; MsgBox Row %RowNumber% was selected.`n  It's World path is: "%WorldPath%".
	   
	   ; Processing here
	   
       LV_Modify(RowNumber, "-Check")                 ; reset checked status
   
	   RowCount += 1
	   }
}

MsgBox, 0, %Script_Name%, Copy Complete, 2

gui, show, , Minecraft Utility

return

exitapp
