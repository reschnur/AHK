; The following example moves all files and folders inside a folder to a different folder

#SingleInstance, Force
SetTitleMatchMode, 2                   ; 1 = Begins with, 2 = Anywhere, 3 = Exact

Script_Name = Move files


SrcFolder := "G:\Off Load\Personal\*.*"
DstFolder   := "D:\OneDrive\Archive\6-Personal\Z-To File - Personal"

; 
ErrorCount := MoveFilesAndFolders("G:\Off Load\Personal\*.*", "D:\OneDrive\Archive\6-Personal\Z-To File - Personal")
if ErrorCount <> 0
    MsgBox %ErrorCount% file move actions resulted in errors.
else
   {
   ;msgbox, 0, ,Personal files were moved.
   run explorer.exe "D:\OneDrive\Archive\6-Personal\Z-To File - Personal"
   }

return


; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Move function
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   
MoveFilesAndFolders(SourcePattern, DestinationFolder, DoOverwrite = false)

; Moves all files and folders matching SourcePattern into the folder named DestinationFolder and
;
; FileMoveDir parm values:
; 0 (default): Do not overwrite existing files. Operation fails if Dest already exists as a file or directory.
; 1 Overwrite existing files. However, any files or subfolders inside Dest that do not have a counterpart in Source will not be deleted. 
;   Known limitation: If Dest already exists as a folder and it is on the same volume as Source, Source will be moved into it rather than overwriting it. 
;   To avoid this, see the next option.
; 2 The same as mode 1 above except that the limitation is absent.
; R Rename the directory rather than moving it. Although renaming normally has the same effect as moving, 
;    it is helpful in cases where you want "all or none" behavior; that is, when you don't want the operation to be only partially 
;    successful when Source or one of its files is locked (in use). Although this method cannot move Source onto a different volume, 
;    it can move it to any other directory on its own volume. The operation will fail if Dest already exists as a file or directory.

{
    if DoOverwrite = 1
        DoOverwrite = 2  ; See FileMoveDir for description of mode 2 vs. 1.
    
	; First move all the files (but not the folders) in the top level(?):
	ifnotexist %sourcepattern%
	  msgbox, Source not found
	  
	ifnotexist %destinationfolder%
	  msgbox, Destination not found
	  
	msgbox, Source: %sourcepattern%`nDestination: %destinationfolder%
	
    FileMove, %SourcePattern%, %DestinationFolder%, %DoOverwrite%
    ErrorCount := ErrorLevel
	
    ; Now move all the folders:
    Loop, %SourcePattern%, 2  ; 2 means "retrieve folders only".
    {
        FileMoveDir, %A_LoopFileFullPath%, %DestinationFolder%\%A_LoopFileName%, %DoOverwrite%
    
        ErrorCount += ErrorLevel                  ; Count of errors for the process

        if ErrorLevel  ; Report each problem folder by name.
            MsgBox Could not move %A_LoopFileFullPath% into %DestinationFolder%.
    }
    
	return ErrorCount
}