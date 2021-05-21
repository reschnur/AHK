; Backup Utility

#SingleInstance, Force
SetTitleMatchMode, 2                ; 1 = Starts with, 2 = Anywhere, 3 = Exact

; Init   

Script_Name = Cities-Skylines Backup
dev = n
tilde = ~
RecNo := 0


; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Build the GUI
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

GUI, 1:Font, s10 bold

Gui, 1:Add, Text, r2 x10 w300, Click the button to continue.
Gui, 1:Font, s10 bold

Gui, 1:Add, Button, x10  w100 h25 gBackup, Backup

gui, 1:show, autosize, %Script_Name%

Return


; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Process GUI
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

; Default actions

GuiEscape:
Gui, Destroy
exitapp

GuiClose:
gui, Destroy
exitapp

ButtonCancel:
gui, Destroy
exitapp


; Clicking the button

Backup:

gui, submit                                        ; Commit the selections


; Define progress GUI
GUI, 2:Font, s10 bold

;Gui, 2:Add, Text, x10 w400 vProfile, Processing profile: %ProfileName%
Gui, 2:Add, Text, x20 w400 vBackupSet, BackupSet Name Here

Gui, 2:show, autosize, %Script_Name%

BackupTime = %A_yyyy%%A_mm%%A_dd% %A_hour%%A_min%%A_sec%
BackupDstBase = E:\Cities Skylines\0-Backup-%BackupTime%

; Copy saves
BackupSet = Saves
copysrcfolder = C:\Users\resch\AppData\Local\Colossal Order\Cities_Skylines\Saves
copydstfolder = %BackupDstBase%\Saves
;msgbox, 0, %Script_Name%, %BackupSet% Backup Complete, 4

Gosub, CopyFiles


; Reports folder
BackupSet = Workshop Assets
;msgbox, 0, Title, %BackupSet%
copysrcfolder = C:\Program Files (x86)\Steam\steamapps\workshop\content\255710
copydstfolder = %BackupDstBase%\Assets

Gosub, CopyFiles


; Loading Screen Mod Reports folder
BackupSet = Mods, Options and Local Assets
;msgbox, 0, Title, %BackupSet%
copysrcfolder = C:\Users\resch\AppData\Local\Colossal Order\Cities_Skylines
copydstfolder = %BackupDstBase%\Mods & Assets
Gosub, CopyFiles

Gui, 2:Cancel

;MsgBox, %copydstfolder%   
run, explorer %BackupDstBase%

ExitApp

; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

CopyFiles:

; GuiControl, 2:Text, ProfileProcessed, Copying Config For: %ProfileName%
GuiControl, 2:Text, BackupSet, Copying %BackupSet%. This could take a while.
Sleep, 400

FileCopyDir, %copysrcfolder%, %copydstfolder%
if ErrorLevel
	MsgBox, 0, %dialogtitle%, The %BackupSet% folder could not be copied., 4

msgbox, 0, %Script_Name%, %BackupSet% Backup Complete, 2

Return
