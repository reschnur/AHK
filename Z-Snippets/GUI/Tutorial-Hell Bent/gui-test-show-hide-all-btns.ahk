#SingleInstance Force

Gui, Add, Radio, x10 y10 Checked Group vRad1, Text1
Gui, Add, Radio, x10 vRad2, Text2
Gui, Add, Radio, x10 vRad3, Text3

Gui, Add, Button, x10 y70 w480 h50 gHideRadios, Hide Radio Buttons
Gui, Add, Button, x10 w480 h50 gShowRadios, Show Radio Buttons

Gui, Show, w500 h500, Gui

Return

GuiEscape:
; Fall thru

GuiClose:
Exitapp

HideRadios:

GuiControl, Hide, Rad1
GuiControl, Hide, Rad2
GuiControl, Hide, Rad3
  
Return


ShowRadios:

GuiControl, Show, Rad1
GuiControl, Show, Rad2
GuiControl, Show, Rad3
  
Return