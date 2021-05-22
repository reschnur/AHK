#SingleInstance Force

Gui, Add, Radio, x10 y10 Checked Group vRad1, Text1
Gui, Add, Radio, x10 vRad2, Text2
GuiControl, Hide, Rad2
Gui, Add, Radio, x10 vRad3, Text3

Gui, Add, Button, x10 y70 w480 h50 gShowRadio2, Show Radio Button 2

Gui, Show, w500 h500, Gui

Return

GuiEscape:
; Fall thru

GuiClose:
Exitapp

ShowRadio2:

GuiControl, Show, Rad2
  
Return