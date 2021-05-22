; Retrieve file names sorted by name, sort by date, write to a file
;

#SingleInstance, Force
SetTitleMatchMode, 2                   ; 1 = Begins with, 2 = Anywhere, 3 = Exact

FileList =                            ; Initialize to be blank.
ScanFolder = C:\Z-Program Files\AHK 1.1.31.01

filedelete, %ScanFolder%\file-list.txt

Loop, %ScanFolder%\*.exe             ; File pattern can vary
{
    FileList = %FileList%%A_LoopFileName%`n
	; MsgBox, 0,, File number %A_Index% is %A_LoopFileName%., 2
}
	
Sort, FileList, R                   ; R = option sorts in reverse order. See Sort help for other options.

Loop, parse, FileList, `n
{
    if A_LoopField =                ; Ignore the blank item at the end of the list.
        continue
		
    MsgBox, 4,, File number %A_Index% is %A_LoopField%.  Continue?
    
	IfMsgBox, No
        break
	
	fileappend, %A_loopfield%`n, %ScanFolder%\file-list.txt
}

run, %ScanFolder%\file-list.txt