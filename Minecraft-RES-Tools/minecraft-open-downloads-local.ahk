; Open two windows and park them side by side.

SetTitleMatchMode, 3 ; 1 = start with 2 = anywhere 3 = exact

SysGet, MonitorWorkArea, MonitorWorkArea
;MsgBox, "Work Area: " %MonitorWorkArea%0

Script_Name    = Minecraft Download Open
WorldNamesFile = 


if (A_ComputerName = "Reliant-DK28321")   ; Desktop
   INIFile        = %A_ScriptDir%\data\minecraft-tools.ini
else
   INIFile        = %A_ScriptDir%\data\minecraft-tools-lt.ini  

RetrieveINIValues:

if(!FileExist(INIFile)) ; no % or error
{
   MsgBox, 48, %Script_Name% - Error-1, Could not find the INI file. Exiting.,4
   winactivate, Error
   exitapp
}

;           Out var,       file,       section, key
IniRead, LocalFolder, %INIFile%, FileLocations, LocalFolder
IniRead, DownloadsFolder, %INIFile%, FileLocations, DownloadsFolder

; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

;openfolder1 := "D:\Richard\OneDrive\Games\Minecraft Downloads"
openfolder1 = %DownloadsFolder% ; \Minecraft Downloads

IfExist, %openfolder1%
   runwait, explore %openFolder1%
else
   MsgBox, The specified folder %openfolder1% does not exist.
   
winactivate, %openfolder1%
winwaitactive, %openfolder1%   
;                title text    x  y                       w                      h
WinMove, %openfolder1%,    ,   0, 0,(MonitorWorkAreaRight*.5), (A_ScreenHeight * .93)
WinGetPos, XPos1, YPos1, Width1, Height1, A

; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  
;openfolder2 := "D:\Richard\OneDrive\Games\Minecraft Profiles"
openfolder2 = %localfolder% ; \Minecraft Downloads

IfExist, %openfolder2%
   runwait, explore %openFolder2%
else
   MsgBox, The specified folder %openfolder2% does not exist.
winactivate, %openfolder2%   
winwaitactive, %openfolder2%   
;                title text    x         y                      w                        h
WinMove, %openfolder2%,    , (Width1), 0, (A_ScreenWidth * .464), (A_ScreenHeight * .93) 
WinGetPos, XPos2, YPos2, Width2, Height2, A
