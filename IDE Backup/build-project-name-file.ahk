; Rebuild file that will be input to the main backup script

; This file contains the folder names of the folders directly under the Software Project folder.

; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Initialize variables
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

ScriptName = Build Software Project Folders ; Must NOT be :=

dev = y
tilde = ~
period = - ; .

ProjectsFolder = C:\Users\resch\Software Projects
ProjectNamesFile = C:\Users\resch\Software Projects\ide-backup-input.txt
MsgBox, 0, %ScriptName%, World Names File:`n%ProjectNamesFile%

BuildProjectNamesFile:

   ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   ; Rebuild world names file
   ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

   ifexist %ProjectNamesfile%
      filedelete, %ProjectNamesfile%

   ; Format the time-stamp.
   timestamp=%A_MM%/%A_DD%/%A_YYYY%, %A_Hour%:%A_Min%:%A_Sec%

   ; Write this data to the file - if it does not exist this command will create it.
   fileappend, File Built: %timestamp%`n, %ProjectNamesfile%

   ; Scan local HD folder   
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

; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

ScanFolder:

   ; scan 
   ; 0=only files, 1=files and folders, 2=folders only
   ; 0 = do not recurse through subfolders, 1 = recurse
   Loop %ProjectsFolder%\*.*, 2, 0 
   {
      projectpath = %A_LoopFileFullPath%
      projectname = %A_LoopFileName%

      MsgBox, 4, %ScriptName%-3, Project Path: %A_LoopFileFullPath%`n`nProject Name: %projectname%`n`nContinue?
      IfMsgBox, No
      break

      fileappend, %projectname%~%projectpath%`n, %ProjectNamesFile%

      ;MsgBox, 4, %ScriptName%-4, Profile Path = %A_LoopFileFullPath%`n`nProfile Name = %projectname%`n`nContinue?
      ;IfMsgBox, No
      ;break
   } ; If ScanComplete

return