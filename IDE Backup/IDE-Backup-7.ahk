; Backup Utility

#SingleInstance, Force
SetTitleMatchMode, 2 ; 1 = Starts with, 2 = Anywhere, 3 = Exact

; Init   

Script_Name = IDE Backup - V2
dev = n
tilde = ~
RecNo := 0

ProjectsFolder = D:\OneDrive\Software-Projects
ProjectNamesFile = D:\OneDrive\Software-Projects\ide-backup-input.txt

; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Rebuild the folder list and load records to an array bypassing unneeded records
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

BackupInput = %ProjectNamesFile%

gosub BuildProjectNamesFile

CountProjectFolders:

  RecNo = 0
  RowCount = 0

  Loop, Read, %BackupInput% 
  {
    RecNo += 1

    if RecNo = 1 ; skip first record - comment
      continue

    RowContent%RowCount% = %A_LoopReadLine% ; 

    RowCount += 1 ;
  }

BuildGUI:

  ; If scroll bars are present, they count as a row. 
  ; If not present then there will be a blank row at the end of the list.
  LVRowCount += RowCount
  ;LVRowCount += RowCount + 1

  GUI, 1:Font, s10 bold
  Gui, 1:Add, Text, x10 w800, Select the Backups you want to backup then click Backup to process your selections.
  Gui, 1:Add, ListView, r%LVRowCount%+1 w900 background006699 cwhite x10 y50 +Center grid checked, Source Name|Source Path ;|Destination Path

  ; Create list view rows

  RowNumber = 0

  While RowNumber < RowCount 	 
  {
    StringSplit, var2_, RowContent%RowNumber%,~ ; 1 = Source Description, 2 = Source path, 3 = SourcePath

    ; MsgBox, 0, %Script_Name%, n1: %var2_1%`n2: %var2_2%

    ; The first column is blank on insert but will contained "checked" if checked.
    LV_Add("", Var2_1, Var2_2)
    LV_ModifyCol(1, "AutoHdr") 
    LV_ModifyCol(2, "AutoHdr") 

    RowNumber += 1
  }

  Gui, 1:Font, s10 bold

  Gui, 1:Add, Button, x10 w100 h25 gProcessSelections, Backup
  Gui, 1:Add, Button, xp+120 yp w100 h25 gOpenInput, Open Input
    GUI, 1:Font, s10 bold
  Gui, 1:Add, Text, xp+140 yp w550 vProgressText, -

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

ProcessSelections:

  gui, submit, nohide ; Commit the selections

  RowNumber := 0 ; This causes the first iteration to start at the top of the list.
  checkedrows = 0

  Loop
  {
    ; Get next row with "Checked" in the first column. Returns 0 if none found.
    RowNumber := LV_GetNext(RowNumber, "Checked") 

    ; without the brackets, the LV_GetText for backup name gets skipped. No idea why.
    if (not RowNumber) 
      break

    checkedrows += 1

    LV_GetText(BackupName, RowNumber, 1) 
    LV_GetText(BackupSrcPath, RowNumber, 2) 

    MsgBox, 0,, Row Number: %RowNumber%`nBackupName: %BackupName%`nBackup Path: %BackupSrcPath%, 4

    copysrcfolder = %BackupSrcPath%
    copydstfolder = E:\Backups\IDE Projects\%BackupName%\As of-%A_yyyy%%A_mm%%A_dd% %A_hour%%A_min%%A_sec%

    GuiControl, 1:Text, ProgressText, Copying files for %BackupName%. Please wait.

    gosub copyfiles

    ; "-Check" tells the GUI to reset the checkbox
    LV_Modify(RowNumber, "-Check")

  } ; loop

  If (checkedrows = 0) {
    msgbox, 0, %Script_Name%, No rows selected., 2
    return
  }

  GuiControl, 1:Text, ProgressText, All backups completed: %checkedrows% rows.

  MsgBox, 4, %ScriptName%, Open the backup folder?
  IfMsgBox, No
    return

exitapp

; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; 
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

CopyFiles:

  FileCreateDir, %copydstfolder%

  MsgBox, 0,,Copy Files: %BackupName%`n From: %copysrcfolder%`n To:%copydstfolder%

  ; Copy Files
  FileCopy, %copysrcfolder%\*.*, %copydstfolder%

  ; Copy directories
  Loop Files, % copysrcfolder "\*", D
  {
    ; msgbox, 0,,Folder Name: %A_LoopFileName%, 2

    If (A_LoopFileName = "node_modules" || A_LoopFileName = ".vscode" || A_LoopFileName = ".git") {
      ; MsgBox, 0,,Bypass, 1
      Continue
    }

    SrcFolder2 = %copysrcfolder%\%A_LoopFileName%
    DstFolder2 = %copydstfolder%\%A_LoopFileName%
    ; MsgBox, 0,,Directory Copy:`n From: %SrcFolder2%`n To: %DstFolder2%, 4

    GuiControl, 1:Text, ProgressText, Copying files for %BackupName%-%A_LoopFileName% - Please wait.

    FileCopyDir %SrcFolder2%, %DstFolder2%
  }

Return

; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

OpenInput:

  Gui, Submit, Nohide
  ;msgbox, 0, %Script_Name%, %BackupInput%
  run %BackupInput%

return

; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

BuildProjectNamesFile:

  ifexist %ProjectNamesfile%
    filedelete, %ProjectNamesfile%

  timestamp=%A_MM%/%A_DD%/%A_YYYY%, %A_Hour%:%A_Min%:%A_Sec%

  fileappend, File Built: %timestamp%`n, %ProjectNamesfile%

  scanfolder = %ProjectsFolder%\*.*

  ; MsgBox, 4, %ScriptName%-2, Scan Path = %scanfolder%`n`nContinue?
  ;IfMsgBox, No
  ;   exitapp

  gosub, ScanFolder

  ; Open file for review - DEBUG ONLY
  if dev = y
    run, %ProjectNamesFile%

  ; msgbox, 0, %script_name%, File Rebuild Complete., 2

return

; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

ScanFolder:

  ; 0=only files, 1=files and folders, 2=folders only
  ; 0=do not recurse through subfolders, 1=recurse
  Loop %ProjectsFolder%\*.*, 2, 0 
  {
    projectpath = %A_LoopFileFullPath%
    projectname = %A_LoopFileName%

    fileappend, %projectname%~%projectpath%`n, %ProjectNamesFile%
  } ; If ScanComplete

return