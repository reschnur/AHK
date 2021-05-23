; Backup Utility

#SingleInstance, Force
SetTitleMatchMode, 2 ; 1 = Starts with, 2 = Anywhere, 3 = Exact

; Init   

Script_Name = IDE Backup
dev = y
tilde = ~
RecNo := 0

ProjectsFolder = C:\Users\resch\Software Projects
ProjectNamesFile = C:\Users\resch\Software Projects\ide-backup-input.txt

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

    GUI, 1:Font, s10 bold
    Gui, 1:Add, Text, x10 w800, Select the Backups you want to backup then click Backup to process your selections.
    Gui, 1:Add, ListView, r%RowCount% w800 background006699 cwhite x10 y50 +Center grid checked, Source Name|Source Path ;|Destination Path

    ; Create list view rows

    RowNumber = 0

    While RowNumber < RowCount 	 
    {
        StringSplit, var2_, RowContent%RowNumber%,~ ; 1 = Source Description, 2 = Source path, 3 = SourcePath

        ; MsgBox, 0, %Script_Name%, n1: %var2_1%`n2: %var2_2%

        LV_Add("", Var2_1, Var2_2) ;, var2_3) ;BackupSrcPath)        
        LV_ModifyCol(1, "AutoHdr") 
        LV_ModifyCol(2, "AutoHdr") 

        RowNumber += 1
    }

    Gui, 1:Font, s10 bold

    Gui, 1:Add, Button, x10 w100 h25 gBackup, Backup
    Gui, 1:Add, Button, xp+120 yp w100 h25 gOpenInput, Open Input
    Gui, 1:Add, Checkbox, xp+110 yp+5 Checked vOpenBackup, Open Backup?
    GUI, 1:Font, s10 bold
    Gui, 1:Add, Text, xp+140 yp w350 vProgressText, -

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

ProcessListviewRows:

    gui, submit, nohide ; Commit the selections

    RowNumber := 0 ; This causes the first iteration to start at the top of the list.
    RowCount = 1

    Loop
    {
        RowNumber := LV_GetNext(RowNumber, "Checked") ; Resume search at row after row found by previous iteration.

        if (not RowNumber) break

        LV_GetText(BackupName, RowNumber, 1) 
        LV_GetText(BackupSrcPath, RowNumber, 2) 

        ; MsgBox, 0,,"Row Number: %RowNumber% `n"BackupName: " %BackupName%, 4

        RowCount += 1

        copysrcfolder = %BackupSrcPath%
        copydstfolder = E:\Backups\IDE Projects\%BackupName%\As of-%A_yyyy%%A_mm%%A_dd% %A_hour%%A_min%%A_sec%

        GuiControl, 1:Text, ProgressText, Copying files for %BackupName%. Please wait.

        gosub copyfiles

        Sleep, 4000

        LV_Modify(RowNumber, "-Check")

        If (RowCount = %CheckedRows%) {
            Break
        }

        If (RowCount = 0) {
            msgbox, 0, %Script_Name%, No rows selected., 2
            Break
        }

        GuiControl, 1:Text, ProgressText, All backups completed: %RowCount% rows.
        If (OpenBackup = 1) {
            run, explorer %copydstfolder%
        }

        return 
    }

exitapp

; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; 
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

CopyFiles:

    ;MsgBox, 0,,Copy 2`n  From: %Source%`n  To:%Dest%
    FileCreateDir, %copydstfolder%

    ; Copy Files
    FileCopy, %copysrcfolder%\*.*, %copydstfolder%

    ; Copy directories
    Loop Files, % copysrcfolder "\*", D
    {
        msgbox, 0,,Folder Name: %A_LoopFileName%, 2

        If (A_LoopFileName = "node_modules" || A_LoopFileName = ".vscode" || A_LoopFileName = ".git") {
            MsgBox, 0,,Bypass, 1
            Continue
        }

        SrcFolder2 = %copysrcfolder%\%A_LoopFileName%
        DstFolder2 = %copydstfolder%\%A_LoopFileName%
        MsgBox, 0,,Directory Copy:`n From: %SrcFolder2%`n To: %DstFolder2%, 4
        GuiControl, 1:Text, ProgressText, Copying files for %BackupName%. %A_LoopFileName% - Please wait.
            ;FileCopyDir %SrcFolder2%, %DstFolder2%
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

    msgbox, 0, %script_name%, File Rebuild Complete., 2

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