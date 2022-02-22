
Script_Name = Mouse clicker

MsgBox, 0, %Script_Name%, Start - F9 to pause, F10 to resume from pause.`n`nBobber must be on pressure plate. Point rod at the note block face., 2

Loop
{
Click, down, right
Sleep, 3000000 ; 6000000 is 2 hours, 2147483647 (original value) is 25 days
Click, up, right
MsgBox, 0, %Script_Name%, Reset, 1
Sleep, 2 ; 10
}

; MsgBox, 0, %Script_Name%, Done, 2

F9::

MsgBox, 0, %Script_Name%, Pause. F10 to resume., 1

Pause

F10::

; MsgBox, 0, %Script_Name%, Reload, 1

Reload
