
SetTitleMatchMode, 3 ; 1 = starts with 2 = anywhere 3 = exact

SysGet, MonitorWorkArea, MonitorWorkArea
;MsgBox, "Work Area: " %MonitorWorkArea%0
Script_Name    = Minecraft Download Open Cloud

if (A_ComputerName = "Reliant-DK28321")   ; Desktop
   INIFile        = %A_ScriptDir%\data\minecraft-tools.ini
else
   INIFile        = %A_ScriptDir%\data\minecraft-tools-lt.ini  

if(!FileExist(INIFile)) ; no % or error
{
   MsgBox, 48, %Script_Name% - Error-1, Could not find the INI file. Exiting.,4
   winactivate, Error
   exitapp
}

;           Out var,       file,       section, key
IniRead, CloudFolder, %INIFile%, FileLocations, CloudFolder
IniRead, DownloadsFolder, %INIFile%, FileLocations, DownloadsFolder
IniRead, GUIBackgroundColor, %INIFile%, UX, GUIBackgroundColor

; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

openfolder1 = %DownloadsFolder% ; \Minecraft Downloads

IfExist, %openfolder1%
   runwait, explore %openFolder1%
else
   MsgBox, The specified folder %openfolder1% does not exist.
   
winactivate, %openfodler1%
winwaitactive, %openfolder1%   
;                title text    x  y                       w                      h
WinMove, %openfolder1%,    ,   0, 0,(MonitorWorkAreaRight*.5), (A_ScreenHeight * .93)
WinGetPos, XPos1, YPos1, Width1, Height1, A

; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  
openfolder2 = %cloudfolder% ; \Minecraft Downloads

IfExist, %openfolder2%
   runwait, explore %openFolder2%
else
   MsgBox, The specified folder %openfolder2% does not exist.
winactivate, %openfolder2%   
winwaitactive, %openfolder2%   
;                title text    x         y                      w                        h
WinMove, %openfolder2%,    , (Width1), 0, (A_ScreenWidth * .464), (A_ScreenHeight * .93) 
WinGetPos, XPos2, YPos2, Width2, Height2, A
