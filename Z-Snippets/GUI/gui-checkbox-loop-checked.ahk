
; colors names: black silver gray white maroon red purple fuschia green lime olive yellow navy blue teal aqua
; color can also be RGB c9c9c9

; cred below is the font color. same rules apply for color names or codes.
;    colors text only not the title row.
; hdr can be -hdr to not show it
; r20 is the initial number of rows (not all may be filled)
; Sort option sorts on column 1 SortDesc sorts descending

; default is readonly rows - readonly allows editing of the rows with wantf2

dev = n

; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Determine which runtime environemnt is being used.
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

if dev = y
   {
   msgbox, 0, %ScriptName%, Running script from dev, 1
   DatapackSrcFolder = G:\Games\Minecraft\Mods & Tools\1-Datapacks\Install
   ToolsFolder = G:\Games\Minecraft\Mods & Tools\2-AHK Scripts\Minecraft RES Tool Suite
   worldnamesfile = %ToolsFolder%\world-names-desktop.txt
   }
else
   if (A_ComputerName = "Reliant-DK28321")   ; Desktop
      {
      msgbox, 0, %ScriptName%, Running script from desktop, 1
      DatapackSrcFolder = D:\Richard\AppData\Roaming\
	  ToolsFolder = D:\Richard\OneDrive\Google Drive\Games\Minecraft Tools\Minecraft RES Tool Suite
      worldnamesfile = %ToolsFolder%\world-names-desktop.txt
      }
   else
      {
      msgbox, 0, %ScriptName%, Running launcher from Surface, 1
      DatapackSrcFolder = c:\Users\resch\Google Drive\Games\Minecraft Tools\Minecraft RES Tool Suite
	  ToolsFolder = c:\Users\resch\Google Drive\GamesMinecraft Tools\Minecraft RES Tool Suite
	  worldnamesfile = %ToolsFolder%\world-names-surface.txt
      }


; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Build the GUI
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

GUI, Font, s10 bold

Gui, Add, ListView, r12 backgroundteal cwhite x10 y50 w390 +Center grid checked , World Name|Profile Name|World Path

recno = 0

Loop, Read, %WorldNamesFile% ; G:\Games\Minecraft\Mods & Tools\2-AHK Scripts\Minecraft RES Tool Suite\world-names-desktop.txt
{
    recno += 1
	
	; skip first record - comment
    if recno = 1
	   continue
	   
	StringSplit, var_,A_LoopReadLine,~;
	
    ;MsgBox, 0, %Script_Name%, 1: %var_1%`n2: %var_2%`n3: %var_3%

	LV_Add("",var_1, var_2, var_3)        ;,var_4,var_5,var_6) ;.... you will need to add as many as you have columns (up to 253 parameters possible)
    LV_ModifyCol(1, "AutoHdr") 
	LV_ModifyCol(2, "AutoHdr") 
	LV_ModifyCol(3, "0")                  ; 0 is the column width. 0 means hide the column. it is still avaialbe for processing.
}


Gui, Add, Text, r2 x10 y6 w390, Select your worlds then click Copy to copy the datapacks in the install folder to the selected worlds.

Gui, Font, s10 bold

Gui, Add, Button, h25 w80 default xm gCopyDatapacks, Copy ; xm positons the button below the prior control

gui, show, , Minecraft Datapack Copy

return

GuiEscape:
Gui, Destroy
exitapp

GuiClose:
gui, Destroy
exitapp


CopyDatapacks:

gui, submit

gosub, CountCheckedRows

If CheckedRows = 0
   {
   MsgBox, 0, %Script_Name%, No worlds were selected.
   exitapp
   }
   
RowNumber = 0                           ; This causes the first loop iteration to start the search at the top of the list.

Loop
{
    RowNumber := LV_GetNext(RowNumber, "Checked")  ; Resume the search at the row after that found by the previous iteration.

    if not RowNumber                    ; The above returned zero, so there are no more selected rows.
       break
    
	LV_GetText(WorldPath, RowNumber, 3)         ; row number is also the array index for the needed path to copy
	
    MsgBox Row %RowNumber% was selected. It's World path is:`n`n"%WorldPath%".
	
	;FileCopy, %datapacksrcfolder%\*.zip, %worldpath%\datapacks
	
	MsgBox, 0, %Script_Name%,Copy datapacks:`n`nFrom:%DatapackSrcFolder%`nTo:%WorldPath%\datapacks
}

MsgBox, 0, %Script_Name%, Copy Complete, 2

exitapp


CountCheckedRows:

CheckedRows = 0
CheckedBoxes =

Loop
{
    RowNumber := LV_GetNext(RowNumber, "Checked")  ; Resume the search at the row after that found by the previous iteration. Could also be abbreviated to C, but Checked is unambiguous.
    if not RowNumber                               ; The above returned zero, so there are no more selected rows.
        break
    
    CheckedBoxes .= CheckedBoxes ? "," RowNumber : RowNumber 
	
    CheckedRows += 1
}

; MsgBox, 0, %Script_Name%, %CheckedRows% rows were checked.`n%checkedboxes%

return


exitapp
#Include Help Popups\Help-Tab-4.ahk