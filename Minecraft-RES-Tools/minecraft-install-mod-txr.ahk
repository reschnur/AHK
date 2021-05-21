; Install mods

; Two different file names are necessary because the file path is stored in the 
; inpt worlds file and there are different file structures for the different machines

; Change to not close the gui. Since there are several version, the iteration migh be usefull.

; Init  

#SingleInstance Force 
Script_Name = Install Mods/Resource Packs

dev = n
tilde = ~
RecNo := 0

INIFile        = %A_ScriptDir%\data\minecraft-tools.ini
WorldNamesFile = 

RetrieveINIValues:

if(!FileExist(INIFile)) ; no % or error
{
   MsgBox, 48, %Script_Name% - Error-1, Could not find the INI file. Exiting.,4
   winactivate, Error
}

;           Out var,       file,       section, key
IniRead, ToolsFolder, %INIFile%, FileLocations, ToolsFolder
IniRead, WorldNamesFile, %INIFile%, FileLocations, WorldNamesFile

/*
MsgBox, 48, %Script_Name%, 
(
INI File`n %INIFile%
Tools Folder`n %ToolsFolder%`n
World Names File: %WorldNamesFile%`n
)
*/

Menu, Tray, Icon, %ToolsFolder%\icons\System-Preferences.ico 

WorldNamesFile = %ToolsFolder%\data\%WorldNamesFile%
; MsgBox, 0, %ScriptName%, World Names File:`n%WorldNamesFile%

RecNo      = 0
RowCount   = 0
Prev_Var_2 =

Loop, Read, %WorldNamesFile% 
{
    RecNo += 1
	
    if RecNo = 1             	   ; skip first record - comment
	   continue
	   
	StringSplit, var_,A_LoopReadLine,~;
	
    ;MsgBox, 0, %Script_Name%, Compare: *%var_2%* - *%prev_var_2%*
	stringcasesense off
	if (var_2 = prev_var_2)        ; without parents it fails. var_2 is the profile name
	   continue

    Prev_Var_2 = %var_2%
	
	RowContent%RowCount% = %A_LoopReadLine%
	
	RowCount += 1
}


; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Build the GUI
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

GUI, Font, s10 bold
   
Gui, Add, Text, r2 x10 y6 w300, Select the profiles you want to install mods for then click Install to process your selections.

Gui, Add, ListView, r%RowCount% background006699 cwhite x10 y50 +Center grid checked, Profile Name|World Path

RowNumber = 0

while RowNumber < RowCount
{
   StringSplit, var2_, RowContent%RowNumber%,~    ; 1 = world name, 2 = profile name, 3 = world path

   splitpath, var2_3, , SavesPath                 ; strip lastpart of var_3 (world name)
   splitpath, SavesPath, , ProfilePath            ; Strip last part of path (saves literal)
	
   ;MsgBox, 0, %Script_Name%, 1: %var2_1%`n2: %var2_2%`n3: %var2_3%`nPath: %profilepath%

   LV_Add("", var2_2, ProfilePath)        
   LV_ModifyCol(1, "AutoHdr") 
   LV_ModifyCol(2, "0")                  ; 0 is the column width. 0 means hide the column. it is still avaialbe for processing.
   
   RowNumber += 1
}


; Gui, Add, CheckBox, x10 vRelease, Unchecked = 1.14.4, checked = 1.15.x

Gui, Add, Button, x10     w100 h40 default xm gSelectFiles, Select Files
Gui, Add, Button, x120 yp w100 h40 gInstallMods, Install Mods
Gui, Add, Button, x230 yp w100 h40 gInstallResourcePacks, Install Resources

gui, show, autosize , %Script_Name%

Return


; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Process GUI
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

; Default actions

GuiEscape:
; Fall thru


GuiClose:
; Fall thru


ButtonCancel:
gui, Destroy
exitapp


SelectFiles:

FileSelectFile, SelectedFiles, M3, %SrcBaseFolder%, Select the mods to install.  ; M3 = Multiselect existing files where the file and path must exist.

if (SelectedFiles = "")
{
    MsgBox, No files selected. Cancel.
    exitapp
}

return


InstallResourcePacks:

gui, submit

Install_Type = resourcepacks
gosub, scan

return


InstallMods:

gui, submit

Install_Type = mods
gosub, scan

return


; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; For each selected profile, copy the selected files then open the profile's mods folder.. 
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Scan:
  
RowNumber := 0                                     ; This causes the first iteration to start at the top of the list.
RowCount   = 0

; Scan the checked items
Loop
{
   RowNumber := LV_GetNext(RowNumber, "Checked")   ; Resume search at row after row found by previous iteration.
   if not RowNumber                                ; The above returned zero, no more selected rows.
      break                                        ; regardless of if statement option the process is complete.
   
   ;MsgBox Row %RowNumber% - %ProfileName% was selected.`n  It's path is: "%ProfilePath%".	   
   RowCount += 1

;  Retrieve needed info from list view fields
   LV_GetText(ProfileName, RowNumber, 1)          
   LV_GetText(ProfilePath, RowNumber, 2)          
	
   if install_type = mods
      copydstfolder = %ProfilePath%\mods
   else
      copydstfolder = %ProfilePath%\resourcepacks

   ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   ; For each file ...
   Loop, parse, SelectedFiles, `n
   {
      if (A_Index = 1)                            ; Entry 1 is the path of the selected files
         FilesToInstallPath = %A_LoopField%
      else
	     IfExist, %CopyDstFolder%
		    FileCopy, %FilesToInstallPath%\%A_LoopField%, %CopyDstFolder%, 1
		 else
		    msgbox, 0, %script_name%, %InstallType% folder does not exist for %ProfileName%. Rebuild the world names file., 2
   }
 	   
   LV_Modify(RowNumber, "-Checked")               ; Reset the row for next display/process iteration
   
   ; Open the destination folder
   run, explorer %CopyDstFolder%
   WinMaximize, A


   If RowCount = %CheckedRows%                    ; Done
      Break	  
}   ; List view


If RowCount > 0
   MsgBox, 0, %Script_Name%, Install Complete, 2
else
   msgbox, 0, %Script_Name%, No rows selected.

exitapp
