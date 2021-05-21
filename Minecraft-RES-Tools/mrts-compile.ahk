;

#SingleInstance, Force
SetTitleMatchMode, 2                ; 1 = Starts with, 2 = Anywhere, 3 = Exact

Script_Name = ScriptName
ahkfolder = C:\Program Files (x86)\AutoHotkey\Compiler
BaseFolder = D:\Richard\OneDrive\Games\Minecraft Tools\Minecraft RES Tool Suite

gosub, compile-installer
exitapp

; /in /out (if different name) /icon
MsgBox, 0, %Script_Name%, Compile launcher, .5
run, %ahkfolder%\ahk2exe.exe /in "%BaseFolder%\minecraft-launcher.ahk"        /out "%BaseFolder%\mrts-launcher.exe"        /icon "%BaseFolder%\icons\launcher.ico"
MsgBox, 0, %Script_Name%, Compile help, .5 
run, %ahkfolder%\ahk2exe.exe /in "%BaseFolder%\minecraft-help.ahk"            /out "%BaseFolder%\mrts-help.exe"            /icon "%BaseFolder%\icons\city-map.ico"
MsgBox, 0, %Script_Name%, Compile utility, .5
run, %ahkfolder%\ahk2exe.exe /in "%BaseFolder%\minecraft-utility.ahk"         /out "%BaseFolder%\mrts-utility.exe"         /icon "%BaseFolder%\icons\utility.ico"
MsgBox, 0, %Script_Name%, Compile world-info, .5
run, %ahkfolder%\ahk2exe.exe /in "%BaseFolder%\minecraft-world-info.ahk"      /out "%BaseFolder%\mrts-world-info.exe"      /icon "%BaseFolder%\icons\world-download.ico"

MsgBox, 0, %Script_Name%, Compile install-mod-txr, .5
run, %ahkfolder%\ahk2exe.exe /in "%BaseFolder%\minecraft-install-mod-txr.ahk" /out "%BaseFolder%\mrts-install-mod-txr.exe" /icon "%BaseFolder%\icons\install.ico"
MsgBox, 0, %Script_Name%, Compile install-dp, .5
run, %ahkfolder%\ahk2exe.exe /in "%BaseFolder%\minecraft-install-dp.ahk"      /out "%BaseFolder%\mrts-install-dp.exe"      /icon "%BaseFolder%\icons\install-datapack.ico"
MsgBox, 0, %Script_Name%, Compile inventory, .5
run, %ahkfolder%\ahk2exe.exe /in "%BaseFolder%\minecraft-inventory.ahk"       /out "%BaseFolder%\mrts-inventory.exe"       /icon "%BaseFolder%\icons\inventory.ico"
MsgBox, 0, %Script_Name%, Compile backup, .5
run, %ahkfolder%\ahk2exe.exe /in "%BaseFolder%\minecraft-backup.ahk"          /out "%BaseFolder%\mrts-backup.exe"          /icon "%BaseFolder%\icons\backup-restore.ico"
MsgBox, 0, %Script_Name%, Compile move-world, .5
run, %ahkfolder%\ahk2exe.exe /in "%BaseFolder%\minecraft-move-world.ahk"      /out "%BaseFolder%\mrts-move-world.exe"      /icon "%BaseFolder%\icons\tools-1.ico"
MsgBox, 0, %Script_Name%, Compile build-ini, .5
run, %ahkfolder%\ahk2exe.exe /in "%BaseFolder%\mrts-build-ini.ahk"            /out "%BaseFolder%\mrts-build-ini.exe"       /icon "%BaseFolder%\icons\tools-1.ico"


compile-installer:

; Compiler the installer to include the above files
; The installer script must be in the same folder as the compiled scripts or it will fail.
MsgBox, 0, %Script_Name%, Compile installer, .5
run, %ahkfolder%\ahk2exe.exe /in "%BaseFolder%\mrts-installer.ahk"            /out "%BaseFolder%\mrts-installer.exe"       /icon "%BaseFolder%\icons\launcher.ico" 

MsgBox, 0, %Script_Name%, Compile completed., 2

ExitApp