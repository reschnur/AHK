; The following example moves all files and folders inside a folder to a different folder

; This method will not work with SharePoint sites even if mapped in Explorer.

#SingleInstance, Force
SetTitleMatchMode, 2                   ; 1 = Begins with, 2 = Anywhere, 3 = Exact

Script_Name = Move files

; Add status GUI here

SrcFolder := "C:\Users\rschnur2\Documents\LSI\BulkMail\Metrics\Senders - Top 20 ST20"
; DstFolder := "C:\Users\rschnur2\Documents\LSI\BulkMail\Test Migrate"

; 
ErrorCount := CopyFilesAndFolders(SrcFolder, DstFolder)    ; No %
if ErrorCount <> 0
    MsgBox %ErrorCount% file move actions resulted in errors.
else
   {
   ;msgbox, 0, ,Personal files were moved.
   run explorer.exe %DstFolder%
   }

return


; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Move function
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   
CopyFilesAndFolders(SourcePattern, DestinationFolder, DoOverwrite = false)

{
	; First move all the files (but not the folders) in the top level(?):
	ifnotexist %sourcepattern%
	  msgbox, Source not found
	  
	ifnotexist %destinationfolder%
	  msgbox, Destination not found
	  
	msgbox, Source: %sourcepattern%`nDestination: %destinationfolder%
	
    ; Now copy all the folders:
    Loop, %SourcePattern%, 2  ; 2 means "retrieve folders only".
    {
	    MsgBox, 0, %Script_Name%, Copy folder: %A_LoopFileFullPath%, 1
		
        FileCopyDir, %A_LoopFileFullPath%, %DestinationFolder%\%A_LoopFileName%, 1 ;%DoOverwrite%
    
        ErrorCount += ErrorLevel                  ; Count of errors for the process

        if ErrorLevel  ; Report each problem folder by name.
            MsgBox Could not move %A_LoopFileFullPath% into %DestinationFolder%.
    }
    
	return ErrorCount
}