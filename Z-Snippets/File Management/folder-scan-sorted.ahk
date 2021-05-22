; Example #4: Retrieve file names sorted by modification date:

FileList =                                        ; Initialize

Loop, Files, %A_MyDocuments%\LSI\*.*, D        ; Include Files and Directories
    FileList = %FileList%%A_LoopFileTimeModified%`t%A_LoopFileName%`n

Sort, FileList  ; Sort by date.

Loop, Parse, FileList, `n
{
    if A_LoopField =                             ; Omit the last linefeed (blank item) at the end of the list.
        continue
    StringSplit, FileItem, A_LoopField, %A_Tab%  ; Split into two parts at the tab char.
    
	MsgBox, 4,, The next file (modified at %FileItem1%) is:`n%FileItem2%`n`nContinue?
    IfMsgBox, No
        break
}