; Install datapacks

; Two different file names are necessary because the file path is stored in the 
; worlds file and there are different file structures for the different machines

#SingleInstance Force
SetTitleMatchMode 2 ;  2 = anywhere

;Menu, Tray, Icon, D:\Richard\OneDrive\Games\Minecraft Tools\Icons\Administrative-Tools.ico

Script_Name = Minecraft Install Datapacks

; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Determine which runtime environment is being used.
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
if (A_ComputerName = "Reliant-DK28321")   ; Desktop
   {
   msgbox, 0, %ScriptName%, Running script from desktop, 1
   DatapackSrcFolder = D:\Richard\OneDrive\Games\Minecraft Downloads\Datapacks
   ToolsFolder = D:\Richard\OneDrive\Games\Minecraft Tools\Minecraft RES Tool Suite\data
   worldnamesfile = %ToolsFolder%\world-names-desktop.txt
   }
else
   {
   msgbox, 0, %ScriptName%, Running script from laptop, 1
   DatapackSrcFolder = c:\Users\resch\Games\Minecraft Downloads\Datapacks
   ToolsFolder = c:\Users\resch\GamesMinecraft Tools\Minecraft RES Tool Suite\data
   worldnamesfile = %ToolsFolder%\world-names-surface.txt
   }


; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Count records so the size of the list view can be set
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
RecNo    = 0
RowCount = 0

Loop, Read, %WorldNamesFile% 
{
    RecNo += 1
	
	; skip first record - comment
    if RecNo = 1
	   continue

    ; Skip bad folder names       case,  start, occurrence	   
    If InStr(A_LoopReadLine, "xxx", false, 1, 1)    
	   continue

    ; Skip bad folder names       case,  start, occurence	   
    If InStr(A_LoopReadLine, "downloads", false, 1, 1)    
	   continue

    RowContent%RowCount% = %A_LoopReadLine%
    RowCount += 1
}

;MsgBox, 0, %Script_Name%, RowCount: %RowCount%, 1


; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Build the GUI
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

GUI, Font, s10 bold

Gui, Add, ListView, r%RowCount% background006699 cwhite x10 y50 w550 +Center grid checked , World Name|Profile Name|World Path

RowNumber = 0

While RowNumber < RowCount
{
	StringSplit, var_, RowContent%RowNumber%,~;
	
	;MsgBox, 0, %Script_Name%, 1: %var_1%`n2: %var_2%`n3: %var_3%

	LV_Add("",var_1, var_2, var_3)        ; var1 = world name, var2 = profile name, var3 = worldpath
    LV_ModifyCol(1, "AutoHdr") 
	LV_ModifyCol(2, "AutoHdr") 
	LV_ModifyCol(3, "0")                  ; 0 is the column width. 0 means hide the column. it is still available for processing.

    RowNumber += 1
}

Gui, Add, Text, r2 x10 y6 w390, Select one or more worlds then click Copy to copy the datapacks in the install folder to the selected worlds.

Gui, Font, s10 bold

Gui, Add, Button, h25 w80 default xm gSelectDatapacks, Select ; xm positions the button below the prior control
Gui, Add, Button, h25 w80 default xm gInstallDatapacks, Install ; xm positions the button below the prior control

gui, show, , Minecraft Datapack Copy

return



; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Process the GUI
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

GuiEscape:
; Fall thru


GuiClose:
gui, Destroy
exitapp


SelectDatapacks:

FileSelectFile, DatapackSelectedFiles, m3, %DatapackSrcFolder%, Select Datapack files.

if (DataPackSelectedFiles = "")
   {
   MsgBox, No files selected. Cancel.
   exitapp
   }
else
   {
   ; msgbox, 0, %script_name%, Files: `n%DataPackSelectedFiles%
   }

return


InstallDatapacks:

gui, submit, nohide

CheckedRows = 0
RowNumber = 0    
Success = 0                       ; This causes the first loop iteration to start the search at the top of the list.

Loop
{
   RowNumber := LV_GetNext(RowNumber, "Checked")  ; Resume the search at the row after that found by the previous iteration.

   if not RowNumber                            ; The above returned zero, so there are no more selected rows.
      break

   CheckedRows += 1   
   
   LV_GetText(WorldName, RowNumber, 1)         ; row number is also the array index for the needed path to copy
   LV_GetText(WorldPath, RowNumber, 3)         ; row number is also the array index for the needed path to copy
	
   ;MsgBox, 0, %Script_Name%, Row %RowNumber% was selected. `n`nIt's World path is:`n`n"%WorldPath%".; , 3
   ;WinActivate, %Script_Name%
	
   ifnotexist, %WorldPath%\datapacks
   {
   	  msgbox, 0, %script_name%, Datapack folder does not exist for %WorldName%. `n`n%WorldPath%\datapacks`n`nRebuild the world names file. ;, 2	
	  continue
   }
	  
   Success += 1 
   run, explorer %WorldPath%\datapacks
	   
   Loop, parse, DatapackSelectedFiles, `n
   {
      if (A_Index = 1)                      ; Entry 1 is the path of the selected files
	     {
         ;MsgBox, The selected files are all contained in %A_LoopField%.
         DatapacksToInstallPath = %A_LoopField%
	     }
      else
         {
         ;MsgBox, 4, %script_name%, The next file is %A_LoopField%.  Continue?
         ;IfMsgBox, No, break
	
		 ;MsgBox, 0, %Script_Name%,Src: %DatapacksToInstallPath%\%A_LoopField%, `n`nDst: %WorldPath%\Datapacks
		 ;WinActivate, %ScriptName%
		
		 FileCopy, %DatapacksToInstallPath%\%A_LoopField%, %WorldPath%\datapacks, 1
         }
   } ; Copy files
	
	;MsgBox, 0, %Script_Name%,Copied datapacks:`n`nFrom:%DatapackToInstallPath%`nTo:%WorldPath%\datapacks

	
} ; Process checked worlds

If CheckedRows > 0
   MsgBox, 0, %Script_Name%, Install Complete - `n   Worlds Selected: %CheckedRows%`n   Worlds Successful %Success%., 2
Else
   MsgBox, 0, %Script_Name%, No worlds were selected.

ExitApp
