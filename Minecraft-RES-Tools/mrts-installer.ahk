; Compiler this script last.

#SingleInstance, Force
SetTitleMatchMode, 2                   ; 1 = Begins with, 2 = Anywhere, 3 = Exact

; InstallFolder   = 32bit exe = x86 folder
; A_WinDir         = c:\windows
; A_AppData        = c:users\<name>\appdata\roaming
; A_AppDataCommon  = C:\ProgramData
; A_Desktop        = c:users\<name>\desktop
; A_DesktopCommon  = c:users\public\desktop
; A_Programs       = C:\Users\<UserName>\AppData\Roaming\Microsoft\Windows\Start Menu
; A_ProgramsCommon = C:\ProgramData\Microsoft\Windows\Start Menu
; A_Startup        = C:\Users\<UserName>\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup
; A_StartupCommon  = C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup
; A_MyDocuments    = C:\Users\<UserName>\Documents
; A_ScriptDir      = directory current script is running from


; Get install folder (default to program files)

;                            , 0 = no options, 1 = allow create new, +2 edit field
FileSelectFolder, InstallFolder, %InstallFolder%, 3, Select folder to install toolset
if InstallFolder =
    MsgBox, You didn't select a folder. Cancel install.
else
    MsgBox, You selected folder "%OutputVar%".
	
; SetWorkingDir, <dirnam>

; Use working directory instead of following
;FileCreateDir, %InstallFolder%\Minecraft RES Tools
FileCreateDir, %InstallFolder%\Minecraft RES Tools
FileCreateDir, %InstallFolder%\Minecraft RES Tools\data

; launcher
; mod/texture installer
; utility
; inventory
; datapack installer
; help (convert to file load to list view so user can customize)
; backup
; archive
; rebuild world names files

; includes the file in this script when it is compiled.
;            source file name,                           dest, overwrite 0 = no, 1 = yes
FileInstall, mrts-backup.exe,          %InstallFolder%\Minecraft RES Tools\mrts-backup.exe, 1
FileInstall, mrts-build-ini.exe,       %InstallFolder%\Minecraft RES Tools\mrts-build-ini.exe, 1
FileInstall, mrts-help.exe,            %InstallFolder%\Minecraft RES Tools\mrts-help.exe, 1
FileInstall, mrts-install-dp.exe,      %InstallFolder%\Minecraft RES Tools\mrts-install-dp.exe, 1
FileInstall, mrts-install-mod-txr.exe, %InstallFolder%\Minecraft RES Tools\mrts-install-mod-txr.exe, 1
FileInstall, mrts-inventory.exe,       %InstallFolder%\Minecraft RES Tools\mrts-inventory.exe, 1
FileInstall, mrts-launcher.exe,        %InstallFolder%\Minecraft RES Tools\mrts-launcher.exe, 1
FileInstall, mrts-move-world.exe,      %InstallFolder%\Minecraft RES Tools\mrts-move-world.exe, 1
FileInstall, mrts-utility.exe,         %InstallFolder%\Minecraft RES Tools\mrts-utility.exe, 1
FileInstall, mrts-world-info.exe,      %InstallFolder%\Minecraft RES Tools\mrts-world-info.exe, 1
; Add INI folder

; Need shortcuts for each of these:
; launcher
; 

;                                                                          target,                         link name,                        work dir, args,                            description,                                                       icon file anme, shortcut key, icon #, runstate 1= normal, 2 = max, 3 = min        
FileCreateShortcut, "%InstallFolder%\Minecraft RES Tools\mrts-launcher.exe", %A_StartupCommon%\Minecraft Tools.lnk, "%InstallFolder%\Minecraft RES Tools\", , MInecraft Tool Suite., "%InstallFolder%\Minecraft RES Tools\icon_cool.ico"

; Add install folder to ini as base location