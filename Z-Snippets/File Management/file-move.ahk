; Move the usb drive offload files to their respective hard drive locations.

#SingleInstance, Force
SetTitleMatchMode, 2                   ; 1 = Begins with, 2 = Anywhere, 3 = Exact

Script_Name = Move Offload Files


; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Count files to be moved. Coun tall folders.
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

FileCount = 0   
 
; Option 1: 0 = files only, 1 = files & folders, 2 = folders only
; Option 2: 0 = don't recurse, 1 = do recurse
loop, G:\Off Load\*.*, 0, 1
    {
    FileCount := A_Index
	}
	
if FileCount = 0
   {
   msgbox, 0, %Script_Name%, No files to process 
   exitapp
   }
else	
   msgbox, 0, %Script_Name%, Files to move: %FileCount%

; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Move personal folder files and then recreate the folder on the source
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   
sourcefolder := "G:\Off Load\Personal"
targetfolder := "D:\Richard\Archive\4-Personal\Z-To File - Personal"

IfExist, %sourcefolder%
  IfExist, %targetfolder%
     {
     FileMoveDir, %SourceFolder%, %TargetFolder%, 1
   
     if ErrorLevel {
        MsgBox, 0, %Script_Name%, The "personal" files could not be moved. It is likely empty. %errorlevel%
        run explorer.exe %targetFolder%
     }
	 FileCreateDir, %sourcefolder%
     }
   else
      MsgBox, The "Personal" target folder does not exist.
else
   MsgBox, The "Personal" source folder does not exist.

; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Count files after move. Could be > 0. Not all folders processed by this script.
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

FileCount = 0   
 
; 0 = files only, 1 = files & folders, 2 = folders only
; 0 = don't recurse, 1 = do recurse
loop, G:\Off Load\*.*, 0, 1
    {
    FileCount := A_Index
	}
	
if FileCount = 0
   {
   msgbox, 0, %Script_Name%, All files were moved.
   exitapp
   }
else	
   msgbox, 0, %Script_Name%, %FileCount% files were left to move manually.

exitapp
