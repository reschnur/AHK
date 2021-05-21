; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Build the files for mods, resource packs, and datapacks used in all installations.
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#SingleInstance Force

; Convert msgboxes to progress. count profiles and use that as the factor

; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Initialize variables

ScriptName = Minecraft Rebuild World Names  ; Must NOT be :=
INIFile        = %A_ScriptDir%\data\minecraft-tools.ini

if(!FileExist(INIFile))         ; No % or error
{
   MsgBox, 48, %Script_Name% - Error-1, Could not find the INI file. Exiting.`n%INIFile%
   winactivate, Error
}

;           Out var,       file,       section, key
IniRead, ToolsFolder, %INIFile%, FileLocations, ToolsFolder
IniRead, LocalFolder, %INIFile%, FileLocations, LocalFolder
IniRead, CloudFolder, %INIFile%, FileLocations, CloudFolder
IniRead, InstallReviewFolder, %INIFile%, FileLocations, InstallReviewFolder
IniRead, ModsUsedFile, %INIFile%, FileLocations, ModsUsedFile
IniRead, ResourcePacksUsedFile, %INIFile%, FileLocations, ResourcePacksUsedFile
IniRead, DatapacksUsedFile, %INIFile%, FileLocations, DatapacksUsedFile

  
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Delete any prior instances of the file and create the new file

FileDelete, %ModsUsedFile%
FileDelete, %ResourcePacksUsedFile%
FileDelete, %DatapacksUsedFile%

; Define process GUI
GUI, Font, s10 bold

Gui, Add, Text, x10 w300, Processing profile:
Gui, Add, Text, x20 w300 vProfileProcessed, Profile Here

Gui, show

; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Scan local HD folder   

scansource = local
scanfolder = %LocalFolder%\*.*

; MsgBox, 4, %ScriptName%-2, Scan Path = %scanfolder%`n`nContinue?
;IfMsgBox, No
;   exitapp

gosub, ScanFolder

; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Scan local cloud folder   

scansource = cloud
scanfolder = %CloudFolder%\*.*

;MsgBox, 4, %ScriptName%-2, Scan Path = %CloudFolder%`n`nContinue?
;IfMsgBox, No
;   exitapp

gosub, ScanFolder

msgbox, 0, %script_name%, File Rebuild Complete., 2

run, explorer %InstallReviewFolder%

Gui, Cancel

ExitApp


; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Scan process

; There are three scan type in this script. THey use one of two scan types:
; Level one scans through the profiles in the specified location (local/cloud)
; Level two scans the world's in the profile and is used to scan for mods and then resource packs
; Level three scans the datapack profile's folder in the world and writes the record to the file
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

ScanFolder:

ScanComplete = n

; scan through profile level 
Loop %scanfolder%, 2                                                            ; 0=only files, 1=files and folders, 2=folders only
{
	profilepath = %A_LoopFileFullPath%
	profilename = %A_LoopFileName%

    ; Update process GUI	
	GuiControl, Text, ProfileProcessed, %ProfileName%

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

    ; Scan the profile's saves folder (the worlds)
    if ScanComplete = y
	   break
	   
    ;MsgBox, 4, %ScriptName%-4, Profile Name = %profilename%`n`nProfile Path = %ProfilePath%`n`nContinue?
    ;IfMsgBox, No
    ;   exitapp
	   
    ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	; Scan the profile's and write the info to the file
	; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	;MsgBox, 0, %Script_Name%, Inventory Mods, 1

    loop %profilepath%\mods\*.*, 0                                           ; 0 only files, 1 both, 2 folders only
    {
	   modname = %A_LoopFileName%
			
       fileappend, %profilename%`,%ModName%`n, %ModsUsedFile%
	}


    ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~	
    ; loop through the profile's resource pack folder and write the info to the file
    ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    ;MsgBox, 0, %Script_Name%, Inventory Resource Packs, 1

    loop %profilepath%\resourcepacks\*.*, 0                                           ; 0 only files, 1 both, 2 folders only
    {
	   ResourcePackName = %A_LoopFileName%
	   
       fileappend, %profilename%`,%ResourcePackName%`n, %ResourcePacksUsedFile%
	} 


    ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    ; Scan the worlds within the profile and write out the datapacks used to a file
    ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~	
	;MsgBox, 0, %Script_Name%, Inventory Datapacks, 1

    loop %profilepath%\saves\*.*, 2                    	; 0 only files, 1 both, 2 folders only
    {
	   WorldPath = %A_LoopFileFullPath%
	   WorldName = %A_LoopFileName%
	   
	   ;MsgBox, 0, %Script_Name%, World Name: %WorldName%, 1
	
       ; Scan the datapacks within the world save
	   loop %WorldPath%\datapacks\*.*, 0
	   {
	      DatapackName = %A_LoopFileName%
 
          fileappend, %profilename%`,%WorldName%`,%DatapackName%`n, %DatapacksUsedFile%
	   } ; datapacks		  
	} ; world saves
	   
} ; Profiles

return