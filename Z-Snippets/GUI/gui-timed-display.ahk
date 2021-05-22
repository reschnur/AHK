; Display a GUI for a fixed amount of time for user input

#SingleInstance, Force
SetTitleMatchMode, 2                   ; 1 = Begins with, 2 = Anywhere, 3 = Exact


; Note that even if in the midst of typing, the GUI will time out, resulting in the default value being used. 
; So, make sure the timer allows enough time for entering or selecting values.

;msgbox, 0, Title, Start

; Create the GUI
Gui Add, Edit, vMyText
Gui Add, Button, gSubmit Default, OK

Gui Show

; Pause to allow for entry.
SetTimer TimeOut, 6000 ;  milliseconds

Return


Submit: ; OK button
Gui Submit
SetTimer TimeOut, Off
GoSub DoStuff
Return

TimeOut: ; Times out
Gui Cancel
SetTimer TimeOut, Off
MyText = Default Value
GoSub DoStuff
Return


DoStuff:

; MsgBox 0, Title, %MyText%, 2

Return