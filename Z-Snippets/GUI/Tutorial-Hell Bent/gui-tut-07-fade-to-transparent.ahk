; Fade to transparent the entire window.

#SingleInstance, Force

Gui, Color, 00dc85

Gui, Add, Button, x10 w200 h200 gLB, Change

Gui, Show, w500 h500, Mini Tut 19

Return

GuiEscape:

GuiClose:
ExitApp

LB:
var := 255
Loop 255
{WinSet, Transparent, %var%, Mini Tut 19
var --
Sleep, 2
}
; Bring it back
Loop 255
{WinSet, Transparent, %var%, Mini Tut 19
var ++
Sleep, 2
}
