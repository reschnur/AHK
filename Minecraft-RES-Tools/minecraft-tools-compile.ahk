;

#SingleInstance, Force
SetTitleMatchMode, 2                ; 1 = Starts with, 2 = Anywhere, 3 = Exact

Script_Name = ScriptName
ahkfolder = C:\Program Files (x86)\AutoHotkey\Compiler
BaseFolder = D:\Richard\OneDrive\Games\Minecraft Tools\Minecraft RES Tool Suite

; /in /out (if different name) /icon
run, %ahkfolder%\ahk2exe.exe /in "%BaseFolder%\minecraft-launcher.ahk"        /out "%BaseFolder%\prod\minecraft-launcher.exe"   /icon "%BaseFolder%\icons\launcher.ico"
run, %ahkfolder%\ahk2exe.exe /in "%BaseFolder%\minecraft-help.ahk"            /out "%BaseFolder%\prod\minecraft-help.exe"       /icon "%BaseFolder%\icons\city-map.ico"
run, %ahkfolder%\ahk2exe.exe /in "%BaseFolder%\minecraft-utility.ahk"         /out "%BaseFolder%\prod\minecraft-utility.exe"    /icon "%BaseFolder%\icons\utility.ico"
run, %ahkfolder%\ahk2exe.exe /in "%BaseFolder%\minecraft-world-info.ahk"      /out "%BaseFolder%\prod\minecraft-world-info.exe" /icon "%BaseFolder%\icons\world-download.ico"

run, %ahkfolder%\ahk2exe.exe /in "%BaseFolder%\minecraft-install-mod-txr.ahk" /out "%BaseFolder%\prod\minecraft-mod-txr.exe"    /icon "%BaseFolder%\icons\install.ico"
run, %ahkfolder%\ahk2exe.exe /in "%BaseFolder%\minecraft-install-dp.ahk"      /out "%BaseFolder%\prod\minecraft-install-dp.exe" /icon "%BaseFolder%\icons\install-datapack.ico"
run, %ahkfolder%\ahk2exe.exe /in "%BaseFolder%\minecraft-inventory.ahk"       /out "%BaseFolder%\prod\minecraft-inventory.exe"  /icon "%BaseFolder%\icons\inventory.ico"
run, %ahkfolder%\ahk2exe.exe /in "%BaseFolder%\minecraft-backup.ahk"          /out "%BaseFolder%\prod\minecraft-backup.exe"     /icon "%BaseFolder%\icons\backup-restore.ico" ; /pass "CustomPassword" /NoDecompile"
run, %ahkfolder%\ahk2exe.exe /in "%BaseFolder%\minecraft-move-world.ahk"      /out "%BaseFolder%\prod\minecraft-move-world.exe" /icon "%BaseFolder%\icons\tools-1.ico"


; Compiler the installer to include the above files
run, %ahkfolder%\ahk2exe.exe /in "%BaseFolder%\minecraft-installer-2.ahk"     /out "%BaseFolder%\prod\minecraft-installer.exe"    /icon "%BaseFolder%\icons\launcher.ico" 

MsgBox, 0, %Script_Name%, Compile completed., 2

ExitApp