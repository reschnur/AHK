; This runs the utility and it runs the world names file rebuild

SetTitleMatchMode, 2       ; 1= starts with; 2 = anywhere; 3=exact

; Common variables

ScriptName = Minecraft Launcher RES
Version = 4.2

Dev = n

if (A_ComputerName = "Reliant-DK28321")   ; Desktop
   {
   msgbox, 0, %ScriptName%, Running launcher from desktop, 1
   INIFile        = %A_ScriptDir%\data\minecraft-tools.ini
   }
else
   {
   msgbox, 0, %ScriptName%, Running launcher from laptop, 1
   INIFile        = %A_ScriptDir%\data\minecraft-tools-lt.ini  
   }

; msgbox, 0, , %INIFile%
WorldNamesFile = 

RetrieveINIValues:

if(!FileExist(INIFile)) ; no % or error
{
   MsgBox, 48, %Script_Name% - Error-1, Could not find the INI file. Exiting.
   winactivate, Error
   exitapp
}

;           Out var,       file,       section, key
IniRead, ToolsFolder, %INIFile%, FileLocations, ToolsFolder


MsgBox, 48, %Script_Name%, 
(
INI File`n %INIFile%
Tools Folder`n %ToolsFolder%`n
GUI Color: %GUIBackgroundColor%`n
)


; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Launch the utility
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

; Check to see if the program is already running

run, %toolsfolder%\minecraft-utility.ahk


; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Launch the help tool and display it
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

;run, %toolsfolder%\minecraft-help.ahk
;Sleep, 200
;msgbox, 0, %ScriptName%, Minecraft Help Loaded., 2
;send ^!h
   
   
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Launch Minecraft
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

run, C:\Program Files (x86)\Minecraft\minecraftlauncher.exe

; Sleep to allow the launcher window to open so the msgbox shows on top of the launcher box.
sleep 6500
msgbox,65,%ScriptName%,Remember:`n`nUtility is activated using ctrl-alt-u`nHelp is activated using ctrl-alt-h, 4
winactivate, %ScriptName% 
 
; msgbox, Procesing completed
   
exitapp

; Version 4.1  Changed to new folder structure and remove version names (no longer on prod scripts)