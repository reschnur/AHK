;

#SingleInstance, Force
SetTitleMatchMode, 2                   ; 1 = Begins with, 2 = Anywhere, 3 = Exact

T_State := 

Gui, 1: +AlwaysOnTop
Gui, 1: Color, Black

Gui, 1: Add, Text, x30 y30 w200 h50 gButton_Press
Gui, 1: Add, Progress, x30 y30 w200 h50 BackgroundWhite c0066aa vMy_Button, 100

Gui, 1: Show, w260 h110, T Button

Return

GuiEscape:
GuiClose:
ExitApp

Button_Press:

GuiControl, 1:+cLime, My_Button
Start_Stime := A_TickCount
While(GetKeyState("LButton")){
Sleep, 10
Tooltip, % (A_TickCount - Start_Time)/1000
}