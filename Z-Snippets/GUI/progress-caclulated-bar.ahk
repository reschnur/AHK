
ScriptName = Progress Bar
SetTitleMatchMode, 2                   ; 1 = Begins with, 2 = Anywhere, 3 = Exact


; Set source folder
;SourceFolder = C:\Users\rschnur2\Documents\LSI\BulkMail\Metrics\Senders - Full SFUL\201902
SourceFolder = D:\Richard\OneDrive\8-Computer\Tool Examples\AHK\GUI

; M allows the window to be moved
; CB Background color
; CT (text color applies to all text in the body of the control window)
; FM/WM refers to main text. This is the text above the bar
; FS/WS refers to sub text which appears below the bar
; R allows a range value different from the default of 0-100.

; Count the files to use as progress range
Loop %SourceFolder%\*.ahk ; csv
{
FilesToProcess += 1
}

; Define progress bar and set range from 0 to the files found
; Define the progress bar and set range to 0 to files found                                   \`````text above`````/\`````` title ``````/
Progress, M R0-%FilesToProcess% CBMaroon CTBlack CWLime h100 ZY10 FM14 WM1000 FS10, Sub-text, Copying the files ..., %ScriptName%-Copy Files
; Variation:
; Define progress bar and set hard a coded range (0-30)
; Progress, M CBMaroon CTBlack CWLime h100 ZY10 R0-30 FM14 WM1000 FS10, Sub-Text, Copying the files ..., %ScriptName%-Working


Loop %SourceFolder%\*.ahk
{
   ; Update the progress bar   
   ;          ar value,\```sub text`````/, - the sub title text value overrides the above value
   Progress, %A_Index%, %A_LoopFileName% 
      
   Sleep, 1800
}

; Kill the progress bar
Progress, off

MsgBox, 0, %ScriptName%, Merge Finished! `n`n%filecount% files have been merged and a log file has been created.

ExitApp

; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

; If you know the number of files you could hard code the range to less than 100 as follows thought e above examples seem far better options and even simpler coding.:
Loop %SourceFolder%\*.csv
{
   FileCount = %A_Index%
   
   ; Since there cannot be more than 31 files,  * 3 gives a better show of progress. 
   ProgressValue := FileCount * 3                      ; no % or the expression will not work

   ; Update the progress bar & display the current file under the bar over writing the text value assigned above.
   ;               bar value, \```sub text`````/,                     main text,             title  - the text values (main, sub, ttile) values override the above values
   Progress, %ProgressValue%, %A_LoopFileName%                                  ; , %ScriptName%-Copying Files... ; , Copying the Files
   ; Progress, %ProgressValue%, %A_LoopFileName%, %ScriptName%-Copying Files... ; , Copying the Files
   
   Sleep, 800
}