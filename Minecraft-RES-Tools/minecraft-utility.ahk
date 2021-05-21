; File format is world name, profile name, world path

#SingleInstance, Force
SetTitleMatchMode, 2                ; 1 = Starts with, 2 = Anywhere, 3 = Exact

dev = n

Script_Name    = Minecraft Utility
WorldNamesFile = 


if (A_ComputerName = "Reliant-DK28321")   ; Desktop
   {
   ;msgbox, 0, %ScriptName%, Running utility from desktop, 1
   INIFile        = %A_ScriptDir%\data\minecraft-tools.ini
   }
else
   {
   ;msgbox, 0, %ScriptName%, Running utility from laptop, 1
   INIFile        = %A_ScriptDir%\data\minecraft-tools-lt.ini  
   }

RetrieveINIValues:

if(!FileExist(INIFile)) ; no % or error
{
   MsgBox, 48, %Script_Name% - Error-1, Could not find the INI file. Exiting.,4
   winactivate, Error
}

;           Out var,       file,       section, key
IniRead, ToolsFolder, %INIFile%, FileLocations, ToolsFolder
IniRead, BackupFolder, %INIFile%, FileLocations, BackupFolder
IniRead, LocalFolder, %INIFile%, FileLocations, LocalFolder
IniRead, CloudFolder, %INIFile%, FileLocations, CloudFolder
IniRead, DownloadsFolder, %INIFile%, FileLocations, DownloadsFolder
IniRead, WorldNamesFile, %INIFile%, FileLocations, WorldNamesFile
IniRead, InstallReviewFolder, %INIFile%, FileLocations, InstallReviewFolder
IniRead, ModsUsedFile, %INIFile%, FileLocations, ModsUsedFile
IniRead, ResourcePacksUsedFile, %INIFile%, FileLocations, ResourcePacksUsedFile
IniRead, DatapacksUsedFile, %INIFile%, FileLocations, DatapacksUsedFile
IniRead, ScreenCapOutputFolder, %INIFile%, FileLocations, ScreenCapOutputFolder
IniRead, GUIBackgroundColor, %INIFile%, UX, GUIBackgroundColor

/*
MsgBox, 48, %Script_Name%, 
(
INI File`n %INIFile%
Tools Folder`n %ToolsFolder%`n
BackupFolder`n %BackupFolder%`n
Local Folder`n %LocalFolder%`n
Cloud Folder`n %CloudFolder%`n
Downloads Folder`n %DownloadsFolder%`n
Install Review Folder`n %InstallReviewFolder%`n
World Names File: %WorldNamesFile%`n
Mods Used File: %ModsUsedFile%`n
Resoureces Used File: %ResourcePacksUsedFile%`n
Datapacks Used File: %DatapacksUsedFile%`n
Pix Folder: %ScreenCapOutputFolder%`n
GUI Color: %GUIBackgroundColor%`n
)
*/

;Menu, Tray, Icon, %ToolsFolder%\icons\Tools-1.ico 
WorldNamesFile = %ToolsFolder%\data\%WorldNamesFile%
; MsgBox, 0, %ScriptName%, World Names File:`n%WorldNamesFile%

;exitapp


; Run program to rebuild world names file.	  
run, %ToolsFolder%\minecraft-install-info.ahk   

ifnotexist %worldnamesfile%
   {
   msgbox, 16, %Script_Name%, No world names file. Exit.
   exitapp
   }


^!u::
KeyWait Control
KeyWait Alt

IfWinExist, Minecraft Utility
{
    WinActivate  ; Automatically uses the window found above.
    return
}

; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Build the GUI
; The dimensions vary depending on the machine and monitor size. Fuss until they fit.
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

; If window exists activate it else move on

GUI, Font, s10 bold

Gui, Add, ListView, r13 background006699 cwhite x10 y50 w550 +Center grid checked , World Name|Profile Name|World Path

recno = 0

Loop, Read, %WorldNamesFile% 
{
    recno += 1
	
	; skip first record - comment
    if recno = 1
	   continue

    ; Skip bad folder names	   
    If InStr(A_LoopReadLine, "xxxx", false, 1, 1)    ; (Pos1 = 1)
	   {
	   ; MsgBox, 0, %Script_Name%, Bypass, 2
	   continue
	   }
	   
	StringSplit, var_,A_LoopReadLine,~;
	
    ;MsgBox, 0, %Script_Name%, 1: %var_1%`n2: %var_2%`n3: %var_3%

	LV_Add("",var_1, var_2, var_3)        ;,var_4,var_5,var_6) ;.... you will need to add as many as you have columns (up to 253 parameters possible)
    LV_ModifyCol(1, "AutoHdr") 
	LV_ModifyCol(2, "AutoHdr") 
	LV_ModifyCol(3, "0")                  ; 0 is the column width. 0 means hide the column. it is still avaialbe for processing.
}

Gui, Add, Text, r2 x10 y6 w620, Select your world (only the first checked box will process) then enter your notes in the box. Click Add Note to add the note to the appropriate world's file.
Gui, Add, Edit,  x570 y50 w440 r16 h200 vnotetext, default note text

Gui, Font, s10 bold
;Gui, Add, Text, r2 x10 y336 w460, Click a buttons below to open the related file. 

Gui, Add, Button, x10  y350 w100 h42 gaddnote, Add Note
Gui, Add, Button, x10  y400 w100 h42 gopennotes, Open Notes
Gui, Add, Button, x120 y350 w100 h42 gmovescreenshots, Move Shots
Gui, Add, Button, x120 y400 w100 h42 gopenscreenshots, Open Shots
Gui, Add, Button, x230 y400 w100 h42 gopenworlds, Open Worlds
Gui, Add, Button, x340 y400 w100 h42 gbackup, Backup
Gui, Add, Button, x560 y400 w100 h42 ginstalldatapacks, Install Datapacks
Gui, Add, Button, x450 y400 w100 h42 ginventory, Inventory
Gui, Add, Button, x670 y350 w100 h42 gopenarchive, Open HD Archive
Gui, Add, Button, x560 y350 w100 h42 ginstallmodstextures, Install Mods/ Textures
Gui, Add, Button, x670 y400 w100 h42 gOpenToolFolder, Open Tool Folder
Gui, Add, Button, x780 y350 w100 h42 gopendownloadslocal, Open Local
Gui, Add, Button, x780 y400 w100 h42 gopendownloadscloud, Open Cloud
Gui, Add, Button, x890 y400 w100 h42 gopendownloadsboth, Open Both

gui, show, , Minecraft Utility

Return


GuiEscape:
Gui, Destroy
return

GuiClose:
gui, Destroy
return


; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Process GUI response
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

addnote:

Gui, Submit, Nohide

gosub, CountCheckedRows

If CheckedRows = 0
   {
   MsgBox, 0, %Script_Name%, No world was selected.
   return
   }

; Only processes the first checked item

RowNumber := LV_GetNext(RowNumber, "Checked")

;MsgBox, 0, %Script_Name%, Row: Row number: %RowNumber%

LV_GetText(WorldName, RowNumber, 1)
LV_GetText(ProfileName, RowNumber, 2)
LV_GetText(WorldPath, RowNumber, 3)
		
WorldNotesFilePath = %WorldPath%\%WorldName%-notes.txt

;MsgBox, 0, %Script_Name%, World: `n%WorldNotesFilePath%`nNote: %NoteText%

; Format the time-stamp.
timestamp=%A_MM%/%A_DD%/%A_YYYY%, %A_Hour%:%A_Min%

; Write this data to the file
fileappend, %worldname% `n %timestamp% `n`n%notetext%`n`n`n, %WorldNotesFilePath%
   
return


opennotes:

Gui, Submit, Nohide

gosub, CountCheckedRows

If CheckedRows = 0
   {
   MsgBox, 0, %Script_Name%, No world was selected.
   
   return
   }

; Only processes the first checked item

RowNumber := LV_GetNext(RowNumber, "Checked")

LV_GetText(WorldName, RowNumber, 1)
LV_GetText(ProfileName, RowNumber, 2)
LV_GetText(WorldPath, RowNumber, 3)

NotesFilePath = %WorldPath%\%WorldName%-Notes.txt

;msgbox, 0, %script_name%, Notes Path: %NotesFilePath%

ifexist %NotesFilePath%
   run, %NotesFilePath%
else
   MsgBox, 0, %Script_Name%, No notes file for this world., 2
   
return


movescreenshots:

Gui, Submit, Nohide

gosub, CountCheckedRows

If CheckedRows = 0
   {
   MsgBox, 0, %Script_Name%, No world was selected.
   return
   }

   
; Get checked row
RowNumber := LV_GetNext(RowNumber, "Checked")

LV_GetText(WorldName, RowNumber, 1)
LV_GetText(ProfileName, RowNumber, 2)
LV_GetText(WorldPath, RowNumber, 3)
 
;Gui, Cancel
;Gui, submit, NoHide
;Gui, destroy

splitpath, WorldPath, , ProfileSavesPath     ; strip world name from path
splitpath, ProfileSavesPath, , ProfilePath   ; Strip saves literal from path

; Add screenshots node & set destination folder
SourceFolder = %profilepath%\screenshots
TargetFolder = %ScreenCapOutputFolder%
  
ifnotexist, %SourceFolder%
   {
   MsgBox, 0, %Script_Name%, Profile path not found., 3
   return
   }

ifnotexist, %TargetFolder%  
   {
   msgbox, 64, %Script_Name%, USB Screenshot folder not found., 3
   return
   }

; Count files in th efolder
count1 = 0

loop, %sourcefolder%\*.png, 1, 0
{
   count1 += 1
}

; Files were found, confirm move and execute the move	 
if count1 > 0 
   {
   MsgBox, 36, %Script_Name%, Confirm moving %count1% screenshots from`n  "%SourceFolder%"`n`nto`n`n"%TargetFolder%".`n`nContinue?
   IfMsgBox, No
      return
	  		 
      ; Move files from source to target. 
      FileMove, %SourceFolder%\*.png, %TargetFolder%, 1

      if ErrorLevel 
         MsgBox, 16, %Script_Name%, The files could not be moved.`nError code: %errorlevel%, 4
      else	  	  
         run explorer.exe %TargetFolder%
   }
else
   {
   msgbox, 64, %Script_Name%, No files found., 2
   return
   }


openscreenshots:

Gui, Submit, Nohide

gosub, CountCheckedRows

If CheckedRows = 0
   {
   MsgBox, 0, %Script_Name%, No world was selected.
   
   return
   }

; Only processes the first checked item

RowNumber := LV_GetNext(RowNumber, "Checked")

LV_GetText(WorldName, RowNumber, 1)
LV_GetText(ProfileName, RowNumber, 2)
LV_GetText(WorldPath, RowNumber, 3)
		
;Gui, Cancel
;Gui, submit, NoHide
;Gui, destroy

splitpath, WorldPath, , ProfileSavesPath     ; strip world name from path
splitpath, ProfileSavesPath, , ProfilePath   ; Strip saves literal from path

msgbox, 0, %Script_Name%, Profile Name: *%profilepath%

run explorer.exe %profilepath%\screenshots
   
return


openworlds:

Gui, Submit, Nohide

;msgbox, 0, %Script_Name%, %worldnamesfile%
run %worldnamesfile%

return


backup:

if dev = y
   MsgBox, 0, %Script_Name%, Run backup script, 2
else
   run, %toolsfolder%\minecraft-backup.ahk

return


installdatapacks:

if dev = y
   MsgBox, 0, %Script_Name%, Run install datapacks script, 2
else
   run, %toolsfolder%\minecraft-install-dp.ahk

return


OpenToolFolder:

run explorer.exe %ToolsFolder%

return


OpenArchive:

run explorer.exe F:\Minecraft

return


inventory:

if dev = y
   MsgBox, 0, %Script_Name%, Run inventory script, 2
else
   run, %toolsfolder%\minecraft-inventory.ahk

return


installmodstextures:

Gui, destroy

if dev = y
   MsgBox, 0, %Script_Name%, Run install mods/textures script, 2
else
   run, %toolsfolder%\minecraft-install-mod-txr.ahk

return


opendownloadslocal:

Gui, destroy

if dev = y
   MsgBox, 0, %Script_Name%, Run open download folders in explorer, 2
else
   run, %toolsfolder%\minecraft-open-downloads-local.ahk

return


opendownloadscloud:

Gui, destroy

if dev = y
   MsgBox, 0, %Script_Name%, Run open download folders in explorer, 2
else
   run, %toolsfolder%\minecraft-open-downloads-cloud.ahk

return


opendownloadsboth:

Gui, destroy

if dev = y
   MsgBox, 0, %Script_Name%, Run open download folders in explorer, 2
else
   run, %toolsfolder%\minecraft-open-downloads-both.ahk

return



; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Subroutines
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

CountCheckedRows:

CheckedRows = 0

Loop
{
    RowNumber := LV_GetNext(RowNumber, "Checked")  ; Resume the search at the row after that found by the previous iteration. Could also be abbreviated to C, but Checked is unambiguous.
    if not RowNumber                               ; The above returned zero, so there are no more selected rows.
        break
		
    CheckedRows += 1
}

;MsgBox, 0, %Script_Name%, %CheckedRows% rows were checked.

return

; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Change log
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

; V2.0   Initial release of the listview based verion
; v3.0   Add buttons for backups and datapack installs so all functions under one umbrella
;        Converted to pathsplit version of parsing world path for navigating up from world path
;        Add checks for dev = y to bypass funcitons that will not work in dev