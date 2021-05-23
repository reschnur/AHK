;

#SingleInstance, Force
SetTitleMatchMode, 2                   ; 1 = Begins with, 2 = Anywhere, 3 = Exact

; A_ProgramFiles   = 32bit exe = x86 folder
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
FileSelectFolder, OutputVar, , 1
if OutputVar =
    MsgBox, You didn't select a folder.
else
    MsgBox, You selected folder "%OutputVar%".
	
; SetWorkingDir, <dirnam>

; Use working directory instead of following
FileCreateDir, %a_ProgramFiles%\Minecraft RES Tools

; launcher
; mod/texture installer
; utility
; inventory
; datapack installer
; help (convert to file load to lsitview so user can cusotmize)
; backup
; archive
; rebuild world names files

; includes the file in this script when it is compiled.
;            source file name,                           dest, overwrite 0 = no, 1 = yes
FileInstall, minecraft-launcher.exe, %a_ProgramFiles%\Minecraft RES Tools\minecraft-launcher.exe , 1
FileInstall, minecraft-install.exe, %a_ProgramFiles%\Minecraft RES Tools\minecraft-install.exe , 1
FileInstall, minecraft-install-datapacks.exe, %a_ProgramFiles%\Minecraft RES Tools\minecraft-install-datapacks.exe , 1
FileInstall, minecraft-backup.exe, %a_ProgramFiles%\Minecraft RES Tools\minecraft-backup.exe , 1
FileInstall, minecraft-help.exe, %a_ProgramFiles%\Minecraft RES Tools\minecraft-help.exe , 1
FileInstall, minecraft-inventory.exe, %a_ProgramFiles%\Minecraft RES Tools\minecraft-inventory.exe , 1
FileInstall, minecraft-utility.exe, %a_ProgramFiles%\Minecraft RES Tools\minecraft-utility.exe , 1
FileInstall, minecraft-move-world.exe, %a_ProgramFiles%\Minecraft RES Tools\rebuild-move-world.exe , 1
FileInstall, minecraft-utility.exe, %a_ProgramFiles%\Minecraft RES Tools\minecraft-utility.exe , 1


; Need shortcuts for each of these:
; launcher
; 

;                                                                          target,                         link name,                        work dir, args,                            description,                                                       icon file anme, shortcut key, icon #, runstate 1= normal, 2 = max, 3 = min        
FileCreateShortcut, "%a_ProgramFiles%\Minecraft RES Tools\Detect Internet Connection.exe", %A_StartupCommon%\Minecraft Tools.lnk, "%a_ProgramFiles%\Minecraft RES Tools\", , MInecraft Tool Suite., "%a_ProgramFiles%\Minecraft RES Tools\icon_cool.ico"

; Add working folder to ini as abse location