;

#SingleInstance, Force
SetTitleMatchMode, 2                   ; 1 = Begins with, 2 = Anywhere, 3 = Exact

var1 := "This is some very long text xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxy"

Gui, 1: +AlwaysOnTop
Gui, 1: Color, Black
Gui, 1: Font, cWhite s12

Gui, 1: Add, Text, x10 y10 w200 Border vText1 gUpdate, Click this text for larger box.

Gui, 1: Show, w300 h300

Return

GuiEscape:
GuiClose:
   ExitApp
   
Update:
; This overlays the bigger text control over the smaller one thus hiding it.
Gui, 2: Font, cWhite s12
Gui, 2: Add, Text, x10 y10 w290 vText2, % var1
GuiControlGet, bob, 2:pos, Text2

Gui, 2: Destroy
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
GuiControl, 1: Move, Text1, h%bobh%
GuiControl, 1:, Text1, % var1 