
ScriptName = File Merge

; Get source folder
FileSelectFolder, SourceFolder, C:\Users\rschnur2\documents\lsi\bulkmail\metrics, 4, Select the folder that contains the files to be merged.

InputBox, MergedFileName, %ScriptName%,Enter the merged file name.`n The file will be saved in the "Merged" folder of the selected source folder., , , , , , , ,merged file.csv

if errorlevel = 1
   exitApp

IfExist, %SourceFolder%\merged\%MergedFileName%
   MsgBox, 52, %ScriptName%-Overwrite -or- Append?, A prior merged file was found.  `n`nDo you want to append to this file or delete it?  `n`nSelect "Yes" to use the existing file.`nSelect "No" to delete the existing file.

ifmsgbox, no
   FileDelete %SourceFolder%\merged\%MergedFileName%

FileCreateDir, %SourceFolder%\merged

; Create log file
IfExist %SourceFolder%\merged\%MergedFilename%_file_list.txt
   FileDelete %SourceFolder%\merged\%MergedFilename%_file_list.txt
   
FileAppend, File Number	Filename`n, %SourceFolder%\merged\%MergedFileName%_file_list.txt

Progress, CBMaroon CTGreen ; CWFuschia FM12 FS16 WM600 WS600 M

Loop %SourceFolder%\*.csv
{
   Fileread, FileRecord, %SourceFolder%\%A_LoopFileName%
   
   FileAppend, %FileRecord%, %SourceFolder%\merged\%MergedFileName%
   
   FileCount = %A_Index%
   
   ; Log the file name
   FileAppend, %filecount%	%A_Loopfilename%`n, %SourceFolder%\merged\%MergedFilename%_file_list.txt
   
   ; Since there cannot be more than 31 files,  * 3 gives a better show of progress. 
   ProgressValue := FileCount * 3                      ; no % or the expression will not work
      
   Progress, %ProgressValue%, %A_LoopFileName%, %ScriptName%-Copying Files..., Copying the Files

}

Progress, off

MsgBox, 0, %ScriptName%, Merge Finished! `n`n%filecount% files have been merged and a log file has been created.

; Open the folder for the merged file
; Run %SourceFolder%\Merged\


exitapp

; This code is not used in this script. It deletes the source files and moves the merged file to the root location. This is not desirable for the bulkmail metrics.

MsgBox, 4, %ScriptName%-Post Process, Do you need to keep the source file?`n`nSelect "Yes" to keep them.`nSelect "no" to delete them. 
IfMsgBox, no
{
   FileDelete %SourceFolder%\*.csv
   
   FileMove, %SourceFolder%\Merged\%MergedFilename%, %SourceFolder%\
   
   FileMove, %SoruceFolder%\merged\%MergedFilename%_file_list.txt, %SourceFolder%\
   
   FileRemoveDir, %SourceFolder%\Merged\
   
   Run %SourceFolder%
}
Else
   Run %SourceFolder%\Merged\

ExitApp