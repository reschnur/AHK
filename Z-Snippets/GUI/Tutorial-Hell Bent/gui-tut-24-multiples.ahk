;

#SingleInstance, Force
SetTitleMatchMode, 2                   ; 1 = Begins with, 2 = Anywhere, 3 = Exact


Gui, 1:+AlwaysOnTop
Gui, 1:Color, Black

Gui, 1:Add, Edit, x10 y10 w480 h400 vEdit1, 
Gui, 1:Add, Button, x150 y435 w200 h40 gLaunch_Gui2, Launch Gui 2

Gui, 1:Show,  w500 h500, Gui Mini Tut 24

OnMessage(0x232, "MoveWindow")

Return

GuiClose:
; Fall thru

GuiCancel:
; Fall thru

GuiEscape:
Exitapp

Launch_Gui2:

Gui, 2:Destroy
WinGetPos, X1, Y1, , , A
Gui, 2: +AlwaysOnTop -caption +Owner1
Gui, 2:Color, Silver
Gui, 2:Add, Edit, xm ym w200 h200 vEdit2,
Gui, 2:Add, Button, xm w200 h40 gUpdate_And_Close, Update && Close
Gui, 2:Show, % "x" X1 + 281 "y" Y1 + 25, Gui 2 

return

Update_And_Close:

Gui, 2:Submit, Nohide
Gui, 2:Destroy
GuiControl, 1:, Edit1, %Edit2%

return


MoveWindow()
{
IfWinExist, Gui 2
{
WinGetPos, X1, Y1, , , A
X2 := X1 +281
Y2 := Y1 +27
Gui, 2:Show, x%X2% y%y2%
}
}
return




esc:: Exitapp
