; Drop down that changes background colo0r based on pull down selection

#SingleInstance, Force
SetTitleMatchMode, 2                   ; 1 = Begins with, 2 = Anywhere, 3 = Exact

;List := "f|b|c|d|e|a|g|h|i|j|"   ; Double || sets default
List := "Blue|Green|Red|Yellow|Aqua|"

Gui, Color, Black
Gui, Margin, +20, +20

Gui, Add, DropDownList, xm ym w200 r10 sort vDDL gSubmit_All, %List%

Gui, Add, Button, xm w200 h40 gDo_Something, Press Me!

Gui, Show, , Gui Mini Tut 23

Return

GuiClose:
ExitApp


Submit_All:

Gui, Submit, Nohide
Tooltip, %DDL%
return

; If "alpha" = no selection


Do_Something:

Gui, Submit, Nohide
Gui, Color, %DDL%
return

esc::ExitApp
