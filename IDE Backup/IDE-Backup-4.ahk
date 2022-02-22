; Backup Utility

; Two different file names are necessary because the file path is stored in the 
; input worlds file and there are different file structures for the different machines

;

#SingleInstance, Force
SetTitleMatchMode, 2 ; 1 = Starts with, 2 = Anywhere, 3 = Exact

; Init   

Script_Name = IDE Backup
dev = n
tilde = ~
RecNo := 0

; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Load records to array bypassing unneeded records
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

BackupProfiles = %A_ScriptDir%\IDE-Backup-Data.txt

RecNo = 0
Prev_Var_2 =
RowCount = 0

Loop, Read, %BackupProfiles% 
{
   RecNo += 1

   ; skip first record - comment
   if RecNo = 1
      continue

   RowContent%RowCount% = %A_LoopReadLine% ; 

   RowCount += 1 ;
}

; msgbox, 0, %Script_Name%, Records read: %RowCount%

; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Build the GUI
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

GUI, 1:Font, s10 bold

Gui, 1:Add, Text, x10 w800, Select the Backups you want to backup then click Backup to process your selections.

Gui, 1:Add, ListView, r%RowCount% w800 background006699 cwhite x10 y50 +Center grid checked, Source Name|Source Path ;|Destination Path

; Create list view rows

RowNumber = 0

While RowNumber < RowCount 	 
{
   StringSplit, var2_, RowContent%RowNumber%,~ ; 1 = Source Description, 2 = Source path, 3 = SourcePath

   ; MsgBox, 0, %Script_Name%, n1: %var2_1%`n2: %var2_2%`n3: %var2_3%

   LV_Add("", Var2_1, Var2_2) ;, var2_3) ;BackupSrcPath)        
   LV_ModifyCol(1, "AutoHdr") 
   LV_ModifyCol(2, "AutoHdr") 
   ;LV_ModifyCol(2, "0")                  ; 0 is the column width. 0 means hide the column. it is still available for processing.

   RowNumber += 1
}

Gui, 1:Font, s10 bold

Gui, 1:Add, Button, x10 w100 h25 gBackup, Backup
Gui, 1:Add, Button, xp+120 yp w100 h25 gOpenInput, Open Input
Gui, 1:Add, Checkbox, xp+110 yp+5 Checked vOpenBackup, Open Backup?
GUI, 1:Font, s10 bold
Gui, 1:Add, Text, xp+140 yp+5 w350 vProgressText, -

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

   gui, submit, nohide ; Commit the selections

   RowNumber := 0 ; This causes the first iteration to start at the top of the list.
   RowCount = 0

   Loop
   {
      RowNumber := LV_GetNext(RowNumber, "Checked") ; Resume search at row after row found by previous iteration.

      if (not RowNumber) ; The above returned zero, no more selected rows.
         break ; The process is complete.

      LV_GetText(BackupName, RowNumber, 1) 
      LV_GetText(BackupSrcPath, RowNumber, 2) 
      ;LV_GetText(BackupDstPath, RowNumber, 3) 

      RowCount += 1

      copysrcfolder = %BackupSrcPath%
      copydstfolder = E:\Backups\IDE Projects\%BackupName%\As of-%A_yyyy%%A_mm%%A_dd% %A_hour%%A_min%%A_sec%

      MsgBox Row %RowNumber% - %BackupName% was selected.`n Src path: "%BackupSrcPath%".`n DstPath: %copydstfolder%, 2

      GuiControl, 1:Text, ProgressText, Copying files for %BackupName%. Please wait.

      if FileExist ( copysrcfolder ) {
      }
      else {
         msgbox, 0, %Script_Name%, Folder %copysrcfolder% not found. Fix input file. 
         continue	 
      }

      ;gosub copyfiles

      ; Show completion in GUI   
      GuiControl, 1:Text, ProgressText, Copy of %BackupName% completed.
      Sleep, 4000

      LV_Modify(RowNumber, "-Check") ; Reset the row for next display/process iteration

      If (RowCount = %CheckedRows%) {
         MsgBox, 0, %Script_Name%, All rows have been processed., 1
         Break	 
      }

      If (RowCount > 0) {
         GuiControl, 1:Text, ProgressText, All backups completed: %RowCount% rows.
         If (OpenBackup = 1) {
            run, explorer E:\Backups\IDE Projects
         }
         else {

         }
      }
      else {
         msgbox, 0, %Script_Name%, No rows selected., 2
      }
      Return
   }

exitapp

; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; 
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

CopyFilesOld:

   ;MsgBox, 0, %Script_Name%, 1: %BackupName%`n2: %BackupSrcPath%`n3: %BackupDstPath%

   FileCopyDir, %copysrcfolder%, %copydstfolder%
   if ErrorLevel
      MsgBox, 0, %dialogtitle%, The %BackupName% folder could not be copied., 2 

return

CopyFiles:

   ;MsgBox, 0,,Copy 2`n  From: %Source%`n  To:%Dest%
   FileCreateDir, %copydstfolder%

   ; Copy Files
   FileCopy, %copysrcfolder%\*.*, %copydstfolder%

   ; Copy directories
   Loop Files, % copysrcfolder "\*", D
   {
      msgbox, 0,,Folder Name: %A_LoopFileName%, 2

      If (A_LoopFileName = "node_modules") {
         MsgBox, 0,,Bypass, 1
         Continue
      }

      SrcFolder2 = %copysrcfolder%\%A_LoopFileName%
      DstFolder2 = %copydstfolder%\%A_LoopFileName%
      MsgBox, 0,,Directory Copy:`n From: %SrcFolder2%`n To: %DstFolder2%
      FileCopyDir %SrcFolder2%, %DstFolder2%
   }

Return

OpenInput:

   Gui, Submit, Nohide
   ;msgbox, 0, %Script_Name%, %BackupProfiles%
   run %BackupProfiles%

return