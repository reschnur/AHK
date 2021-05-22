Loop
{
    FileReadLine, line, "C:\Users\resch\AppData\Roaming\.minecraft 1.13.2 Forge\config\XaeroWaypoints\1%us%13%us%0-Village 857757\overworld\waypoints.txt", %A_Index%
    if ErrorLevel
        break

		MsgBox, 4, , Line #%A_Index% is "%line%".  Continue?
    IfMsgBox, No
        return
}
MsgBox, The end of the file has been reached or there was a problem.

return