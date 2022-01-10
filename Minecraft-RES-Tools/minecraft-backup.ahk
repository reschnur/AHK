; Backup Utility

; Two different file names are necessary because the file path is stored in the 
; inpt worlds file and there are different file structures for the different machines

;

#SingleInstance, Force
SetTitleMatchMode, 2                ; 1 = Starts with, 2 = Anywhere, 3 = Exact


; Init   

Script_Name = Minecraft Backup
dev = n
tilde = ~
RecNo := 0


RetrieveINIValues:

INIFile        = %A_ScriptDir%\data\minecraft-tools.ini

if(!FileExist(INIFile)) ; no % or error
{
   MsgBox, 48, %Script_Name% - Error-1, Could not find the INI file. Exiting.,4
   winactivate, Error
}

;           Out var,       file,       section, key
IniRead, ToolsFolder, %INIFile%, FileLocations, ToolsFolder
IniRead, BackupFolder, %INIFile%, FileLocations, BackupFolder
IniRead, WorldNamesFile, %INIFile%, FileLocations, WorldNamesFile

/*
MsgBox, 48, %Script_Name%, 
(
INI File:`n%INIFile%`n`n
Tools Folder`n%ToolsFolder%`n`n
Backup Folder:'n%BackupFolder%'n`n
World Names File:%WorldNamesFile%`n
)
*/



; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Load records to array bypassing unneeded records
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


WorldNamesFile = %ToolsFolder%\data\%WorldNamesFile%

RecNo      = 0
Prev_Var_2 =
RowCount   = 0

Loop, Read, %WorldNamesFile% 
{
    RecNo += 1
	
	; skip first record - comment
    if RecNo = 1
	   continue

    ; Skip bad folder names       case,  start, occurrence	   
    If InStr(A_LoopReadLine, "xxx", false, 1, 3)    
	   continue

    ; Skip downloads folder. there is no need to back it up.
    If InStr(A_LoopReadLine, "downloads", false, 1, 1)    
	   continue
	   
	StringSplit, var_,A_LoopReadLine,~        ; 1 = world name, 2 = profile name, 3 = world path

	stringcasesense off
	if (var_2 = Prev_Var_2)                   ; without parents it fails - var_2 is the profile name
	   continue

    Prev_Var_2 = %var_2%                      ; save this profile for comparing to the next profile
	
	RowContent%RowCount% = %A_LoopReadLine%   ; 
	
	RowCount += 1                             ;
}


; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Build the GUI
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

GUI, 1:Font, s10 bold

Gui, 1:Add, Text, r2 x10 w300, Select the profiles you want to backup then click Backup to process your selections.

Gui, 1:Add, ListView, r%RowCount% background006699 cwhite x10 y50 +Center grid checked, Profile Name|World Path

; Create list view rows

RowNumber = 0

While RowNumber < RowCount  	  
{
    StringSplit, var2_, RowContent%RowNumber%,~    ; 1 = world name, 2 = profile name, 3 = world path
	
	;           input, outfile, outpath
	splitpath, var2_3,        ,SavesPath           ; strip last part of var_3 (world name)
    splitpath, SavesPath,     , ProfilePath        ; Strip last part of path (saves literal)
	
    ;MsgBox, 0, %Script_Name%, 1: %var2_1%`n2: %var2_2%`n3: %var2_3%`nPath: %ProfilePath%

	LV_Add("", Var2_2, ProfilePath)        
    LV_ModifyCol(1, "AutoHdr") 
	LV_ModifyCol(2, "0")                  ; 0 is the column width. 0 means hide the column. it is still available for processing.
	
	RowNumber += 1
}


Gui, 1:Font, s10 bold

Gui, 1:Add, Button, x10  w100 h25 gBackup, Backup

gui, 1:show, autosize, %Script_Name%

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

ButtonCancel:
gui, Destroy
exitapp


; Clicking the button

Backup:

gui, submit                                        ; Commit the selections
  
RowNumber := 0                                     ; This causes the first iteration to start at the top of the list.
RowCount   = 0

; Define progress GUI
GUI, 2:Font, s10 bold

;Gui, 2:Add, Text, x10 w400 vProfile, Processing profile: %ProfileName%
Gui, 2:Add, Text, x20 w500 vProfileProcessed, Profile Name Here

Gui, 2:show, autosize, %Script_Name%

Loop
{
   RowNumber := LV_GetNext(RowNumber, "Checked")   ; Resume search at row after row found by previous iteration.

   if not RowNumber                                ; The above returned zero, no more selected rows.
      break                                        ; regardless of if statement option the process is complete.
   else
      {    
      LV_GetText(ProfileName, RowNumber, 1)          
	  LV_GetText(ProfilePath, RowNumber, 2) 

      ;MsgBox Row %RowNumber% - %ProfileName% was selected.`n  It's path is: "%ProfilePath%".
	   
      RowCount += 1

	  copysrcfolder = %ProfilePath%
      copydstfolder = %BackupFolder%\0-Backup - Profiles\MCB-%A_yyyy%%A_mm%%A_dd% %A_hour%%A_min%%A_sec%-Profile-%ProfileName%
	
      gosub copyfiles
	   
      LV_Modify(RowNumber, "-Checked")               ; Reset the row for next display/process iteration

      If RowCount = %CheckedRows%
         {
            MsgBox, 0, %Script_Name%, No more rows., 1
            Break	  
         }
	  }   ; else
} ; main loop

If RowCount > 0
   {
   MsgBox, 0, %Script_Name%, Backup Complete, 2
   run, explorer %BackupFolder%
   }
else
   msgbox, 0, %Script_Name%, No rows selected., 2

exitapp


; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; 
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

CopyFiles:

GuiControl, 2:Text, ProfileProcessed, Copying Config For: %ProfileName%
Sleep, 500

FileCopyDir, %copysrcfolder%\config, %copydstfolder%\config
if ErrorLevel
   MsgBox, 0, %dialogtitle%, The %ProfileName% config folder could not be copied., 2 


; Saves folder (incudes the notes and goals files)
GuiControl, 2:Text, ProfileProcessed, Copying Saves For: %ProfileName%. This will take a while.
Sleep, 400

FileCopyDir, %copysrcfolder%\saves, %copydstfolder%\saves
if ErrorLevel
   MsgBox, 0, %dialogtitle%, The %ProfileName% saves folder could not be copied., 2


; Waypoints - Voxel
WaypointFolder = %copysrcfolder%\mods\mamiyaotaru\voxelmap

If FileExist(WaypointFolder)
   {
   GuiControl, 2:Text, ProfileProcessed, Copying Voxel Waypoints For: %ProfileName% 
   Sleep, 400
   
   FileCopyDir, %WaypointFolder%, %copydstfolder%\voxelmap
   if ErrorLevel
      MsgBox, 0, %dialogtitle%, The %ProfileName% waypoints folder could not be copied., 2
   }

; Waypoints - Xaero
WaypointFolder = %copysrcfolder%\XaeroWaypoints

If FileExist(WaypointFolder)
   {
   GuiControl, 2:Text, ProfileProcessed, Copying Xaero Waypoints For: %ProfileName% 
   Sleep, 400
   
   FileCopyDir, %WaypointFolder%, %copydstfolder%\XaeroWaypoints
   if ErrorLevel
      MsgBox, 0, %dialogtitle%, The %ProfileName% Xaero waypoints folder could not be copied., 2
   }

; Waypoints - JustMap
WaypointFolder = %copysrcfolder%\justmap

If FileExist(WaypointFolder)
   {
   GuiControl, 2:Text, ProfileProcessed, Copying JustMap Waypoints For: %ProfileName% 
   Sleep, 400
   
   FileCopyDir, %WaypointFolder%, %copydstfolder%\JustMap Waypoints
   if ErrorLevel
      MsgBox, 0, %dialogtitle%, The %ProfileName% JustMap waypoints folder could not be copied., 2
   }

; Waypoints - JOurneyMap
WaypointFolder = %copysrcfolder%\journeymap

If FileExist(WaypointFolder)
   {
   GuiControl, 2:Text, ProfileProcessed, Copying Journey Map Waypoints For: %ProfileName% 
   Sleep, 400
   
   FileCopyDir, %WaypointFolder%, %copydstfolder%\Journey Map Waypoints
   if ErrorLevel
      MsgBox, 0, %dialogtitle%, The %ProfileName% Journey Map folder could not be copied., 2
   }

return
