; Example #4: Retrieve file names sorted by modification date:

FileList =

Loop, Files, %A_MyDocuments%\Photos\*.*, D       ; D = Include Files and Directories
    FileList = %FileList%%A_LoopFileTimeModified%`t%A_LoopFileName%`n   ; `n = tab

;                 U=remove duplicates, R=descending, N=numeric, C=Case sensitive, CL=case insensitive	
Sort, FileList  ; Sort by date because the Time Modified field is first in the string.

Loop, Parse, FileList, `n
{
    if A_LoopField =                             ; Omit the last linefeed (blank item) at the end of the list.
        continue

	StringSplit, FileItem, A_LoopField, %A_Tab%  ; Split into two parts at the tab char.

    MsgBox, 4,, The next file (modified at %FileItem1%) is:`n%FileItem2%`n`nContinue?
    IfMsgBox, No
        break
}