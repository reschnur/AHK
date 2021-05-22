; When middle button is clicked, count from 5 to 1 then display "Done"

#SingleInstance, Force
SetTitleMatchMode, 3                ; 1=Starts with, 2=anywhere, 3=Exact

Hotkey, MButton, MButton

Return


MButton:
 Hotkey, MButton, MButton_Disabled	;effectively disables MButton hotkey

 Gui +LastFound +AlwaysOnTop -Caption +ToolWindow
 Gui Color, EEAA99
 Gui Font, s228
 Gui Add, Text, X20 Y20 W200 Vdisp Cred
 WinSet TransColor, EEAA99
 Gui Show, NoActivate, Display

 secsLeft = 6
 SetTimer, ShowTimer, -850
 Gosub ShowTimer

 Return

ShowTimer:
  secsLeft--
  IfEqual, secsLeft, 0
  {
    SetTimer ShowTimer, Off
    GuiControl,, disp		;clear the last "1"

    ; Resize window/control for longer text
    WinMove, Display,, 1,1, %A_ScreenWidth%, %A_ScreenHeight%
    GuiControl, Move, disp, % "X" 20 "Y" 20 "W" (A_ScreenWidth-25) "H" (A_ScreenHeight-25) ; %

    ; Display text message briefly
    GuiControl,, disp, Done!
    Sleep, 1000

    Gui, Destroy
    Hotkey, MButton, MButton		;"re-enable" MButton

    ; Now may click the window's button
    ;ControlClick, Button2, MyProgram
    ;msgbox Clicked the button!
  }
  Else
  {
    Sleep, 200
    GuiControl, Text, disp, %secsLeft%
    SetTimer, ShowTimer, -850
  }
Return

MButton_Disabled:
Return