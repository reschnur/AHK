;

basefolder = W:\GNCO\Bulkmail\List Info XLS
dstfolder = %basefolder%\Backups\%a_yyyy%\%a_mmm%


; Check for destination folder. The move will fail if the folder does not exist.
ifnotexist %dstfolder%
{
   FileCreateDir, %dstfolder%
   if errrorlevel
   {
      msgbox, 48, Rename BulkMail XLS Files, Could not create destination folder. Terminate.
	  exitapp
   }
}

; If file exists then move it and rename it.
ifexist %basefolder%\lastactv.csv
{
;   msgbox, S: %basefolder%`nD: %dstfolder%
   filemove %basefolder%\lastactv.csv, %dstfolder%\lastactv-%a_yyyy%-%a_mm%-%a_dd%.csv, 0
   if errorlevel
      msgbox, 48, Rename BulkMail XLS Files, Error Code: %errorlevel% moving LASTACTV.CSV
}
else
   msgbox, 48, Rename BulkMail XLS Files, LASTACTV.CSV file does not exist.

   
; If file exists then move it and rename it.
ifexist %basefolder%\list.managers
{
   filemove %basefolder%\list.managers, %dstfolder%\list-managers-%a_yyyy%-%a_mm%-%a_dd%.csv, 0
   if errorlevel
      msgbox, 48, Rename BulkMail XLS Files, Error Code: %errorlevel% moving LIST.MANAGERS
}
else
   msgbox, 48, Rename BulkMail XLS Files, LIST.MANAGERS file does not exist.

   
; If file exists then move it and rename it.
/*  ~~~~~~~~~~~~~ file no longer needed  ~~~~~~~~~~~~~~~~~~~~~~~~~~~
ifexist %basefolder%\listownr.data
{
   filemove %basefolder%\listownr.data, %dstfolder%\list-owners-%a_yyyy%-%a_mm%-%a_dd%.csv, 0
   if errorlevel
      msgbox, 48, Rename BulkMail XLS Files, Error Code: %errorlevel% moving LISTOWNR.DATA
}
else
   msgbox, 48, Rename BulkMail XLS Files, LISTOWNR.DATA file does not exist.
*/

msgbox, 32, Rename BulkMail XLS Files, Process complete., 2   
  
; run explorer %dstfolder%

exitapp