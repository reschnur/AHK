#SingleInstance, Force

Scrolling_Text := "~~~~~~~~~~~~~  Breaking News ~~~~~~~~~~~~~~"
x1 := 10

Gui, Font, s26
Gui, Add, GroupBox, x-10 y10 w1370 h100
Gui, Add, Text, cAqua x%x1% y50 vMoving_Text, %Scrolling_Text%

Gui, Add, Button, x10 y150 w1330 h50 gStart_Moving, Start Moving Text

Gui, +AlwaysOnTop
Gui, Color, Black

Gui, Show, x0 y0 w1350 h210, Scrolling Text

Return

GuiEscape:
; Fall Thru

GuiClose:
ExitApp


Start_Moving:

Loop
{
   x1 += 2
   
   if (x1 >= 1350)
      {
      x1 := -380
      GuiControl, Move, Moving_Text, x%x1%
      }
   else
      {
      GuiControl, Move, Moving_Text, x%x1%
      }
	  
   Sleep, 10
}
Return
