;

#SingleInstance, Force
SetTitleMatchMode, 2                   ; 1 = Begins with, 2 = Anywhere, 3 = Exact

Script_Name = Loop Read

; Select file
FileSelectFile, SelectedFile, 3, C:\Users\resch\AppData\Roaming\.minecraft 1.13.2 Forge\config\XaeroWaypoints, Open a file ; , Text Documents (*.txt; *.doc)
if SelectedFile =
   {
   MsgBox, The user didn't select anything.
   ExitApp
   }
else
    MsgBox, The user selected the following:`n%SelectedFile%
	

; Using Loop, Read
Loop, read, %SelectedFile%
{
    waypoint = %A_LoopReadLine%
    msgbox, 0, %Script_Name%, Record: %waypoint%, 2
}

exitapp


; Using FileReadLine
Loop
{
    FileReadLine, line, %SelectedFile%, %A_Index%
    if ErrorLevel                                    ; End of file or an error
	   break
    	
	MsgBox, 4, %Script_Name%, Line #%A_Index% is "%line%".  Continue?
    IfMsgBox, No
        return
}
MsgBox, The end of the file has been reached or there was a problem.

ExitApp