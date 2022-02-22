; Rebuild Minecraft world names file for tool suite use

; This version stores the world name, profile name, and world path as separate fields.
; The prior version stored the world name and profile name as a concatenated field.
; It made the pick list look messy and confusing.

; The change was also to help with the list view in the utility and other scripts. 
; The world path is hidden in the listview entries, but can be extracted when used. 
; This is more efficient than working in arrays or other methods.


; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Initialize variables
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

ScriptName = Minecraft Rebuild World Names  ; Must NOT be :=

dev = n
tilde = ~
period = - ; .


if (A_ComputerName = "Reliant-DK28321")   ; Desktop
   {
   ;msgbox, 0, %ScriptName%, Running Install Info from desktop, 1
   INIFile        = %A_ScriptDir%\data\minecraft-tools.ini
   }
else
   {
   ;msgbox, 0, %ScriptName%, Running Install Info from laptop, 1
   INIFile        = %A_ScriptDir%\data\minecraft-tools-lt.ini  
   }

WorldNamesFile = 

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
Resources Used File: %ResourcePacksUsedFile%`n
Datapacks Used File: %DatapacksUsedFile%`n
Pix Folder: %ScreenCapOutputFolder%`n
GUI Color: %GUIBackgroundColor%`n
)
*/

WorldNamesFile = %ToolsFolder%\data\%WorldNamesFile%
; MsgBox, 0, %ScriptName%, World Names File:`n%WorldNamesFile%

   
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Rebuild world names file
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

ifexist %worldnamesfile%
   filedelete, %worldnamesfile%


; Format the time-stamp.
timestamp=%A_MM%/%A_DD%/%A_YYYY%, %A_Hour%:%A_Min%:%A_Sec%

; Write this data to the file - if it does not exist this command will create it.
fileappend, File Built: %timestamp%`n, %worldnamesfile%

; Scan local HD folder   
scansource = local
scanfolder = %LocalFolder%\*.*

; MsgBox, 4, %ScriptName%-2, Scan Path = %scanfolder%`n`nContinue?
;IfMsgBox, No
;   exitapp

gosub, ScanFolder


; Scan local cloud folder   
scansource = cloud
scanfolder = %CloudFolder%\*.*

;MsgBox, 4, %ScriptName%-2, Scan Path = %CloudFolder%`n`nContinue?
;IfMsgBox, No
;   exitapp

gosub, ScanFolder

; Open file for review - DEBUG ONLY
if dev = y
   run, %WorldNamesFile%

;msgbox, 0, %script_name%, File Rebuild Complete., 2

return


; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

ScanFolder:

ScanComplete = n

; scan through profile level
Loop %scanfolder%, 2  ; 0=only files, 1=files and folders, 2=folders only
{
	profilepath = %A_LoopFileFullPath%
	profilename = %A_LoopFileName%
	
    ;MsgBox, 4, %ScriptName%-3, Profile Path: %A_LoopFileFullPath%`n`nProfile Name: %profilename%`n`nContinue?
    ;IfMsgBox, No
    ;   break

	StringLeft, ProfilePrefix, profilename, 10
	
	If ScanSource = local
	   if ProfilePrefix <> .minecraft
          ScanComplete = y
	   else
	      ScanComplete = n
	else
	   If ProfilePrefix = xxxxxxxxxx 
	      ScanComplete = y
	   else 
	      ScanComplete = n
	
    if ScanComplete = n	
	   {
       ;MsgBox, 4, %ScriptName%-4, Profile Path = %A_LoopFileFullPath%`n`nProfile Name = %profilename%`n`nContinue?
       ;IfMsgBox, No
       ;   break

       ; loop through profile folder for world names
       loop %profilepath%\saves\*.*, 2
       {
	      worldpath = %A_LoopFileFullPath%
	      worldname = %A_LoopFileName%
		
          ;MsgBox, 4, %ScriptName%-5, World Name = %A_LoopFileName%`n`nProfile Name = %profilename%`n`nContinue?
	      ;IfMsgBox, No
          ;   break
			
          fileappend, %worldname%~%profilename%~%worldpath%`n, %worldnamesfile%
	   } ; profilepath
	   } ; If ScanComplete
	else
	   {
	   ;MsgBox, 4, %ScriptName%-5, End of Minecraft folders., 1
	   break
	   }
}

return