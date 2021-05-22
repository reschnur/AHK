; This script will merge daily bulkmail metrics files into a monthly file.
; Excel cannot open the full senders and full lists files in the folders. They are too large - too many rows.
; Using this script to merge the files into a single file, it can then be imported to Access and filtered to a level that Excel will handle.
; It can also be used in the extract script.

#SingleInstance force

; Init
ScriptName = BulkMail Metrics File Merge
CancelUserOperation = 1
;FileSelectBase = C:\Users\rschnur2\Documents\2020     ; debug
FileSelectBase = W:\GNCO\Bulkmail\BulkMail Metrics    ; Prod

; Get source folder
FileSelectFolder, SourceFolder, %FileSelectBase%, 2, Select the folder that contains the files to be merged.

if errorlevel = %CancelUserOperation%
   exitApp

   
; Extract values from source path for use in default file name value
SplitPath, SourceFolder, SourceYYYYMM, SourceTypePath             ; 
SplitPath, SourceTypePath, SourceYYYY, SourceTypePath             ;
SplitPath, SourceTypePath, SourceType                             ;
;msgbox, 1, %Script_Name%, Source Folder: %SourceFolder%`nSource Type Path: %SourceTypePath%`nSource Type: %SourceType%`nSource YYYYMM: %SourceYYYYMM%


; Get output file name
InputBox, MergedFileName, %ScriptName%,Enter the merged file name.`n The file will be saved in the "Merged" folder of the selected source folder., , , , , , , ,%SourceType%-%SourceYYYYMM%-Merged.csv

if errorlevel = %CancelUserOperation%
   exitApp

   
IfExist, %SourceFolder%\merged\%MergedFileName%
   MsgBox, 52, %ScriptName%-Overwrite -or- Append?, A prior merged file was found. Do you want to append to this file or delete it?  `n`nSelect "Yes" to use the existing file.`nSelect "No" to delete the existing file.

ifmsgbox, no
   FileDelete %SourceFolder%\merged\%MergedFileName%

FileCreateDir, %SourceFolder%\merged


; Create log file
MergedFilesLogName = %SourceFolder%\merged\%SourceType%-%SourceYYYYMM%_files_merged_log.txt
IfExist %MergedFilesLogName%
   FileDelete %MergedFilesLogName%
   
FileAppend, File Number	Filename`n, %MergedFilesLogName%

; Define the progress bar for the merge process
Progress, M H100 CBGreen CTBlack CWSilver, , Merging Files ..., %ScriptName%

FileCount = 0

; Create merged file
Loop %SourceFolder%\*.csv
{
   Fileread, FileRecord, %SourceFolder%\%A_LoopFileName%
   
   FileAppend, %FileRecord%, %SourceFolder%\merged\%MergedFileName%
   
   FileCount = %A_Index%
   
   ; Log the file name
   FileAppend, %filecount%	%A_Loopfilename%`n, %MergedFilesLogName%
   
   ; Since there cannot be more than 31 files,  * 3 gives a better show of progress. 
   ProgressValue := FileCount * 3                                               ; no % or the expression will not work
      
   Progress, %ProgressValue%, %A_LoopFileName%
}


; Finish
Progress, off

MsgBox, 36, %ScriptName%, Merge Finished! `n`n%filecount% files have been merged and a log file has been created.`n`nWould you like to view the file folder?

ifmsgbox, yes
   Run, explorer %SourceFolder%\Merged\

exitapp

ExitApp

; Change log:

; v1.0   Initial release
; V2.0   Switg h from drive C to W