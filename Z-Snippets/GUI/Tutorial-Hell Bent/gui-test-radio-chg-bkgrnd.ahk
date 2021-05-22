; Clicking the button changes the background color of the window

Gui, Color, Red

Gui, Add, Radio, x10 y10 Checked Group vRad1 gRadio_Label, White
Gui, Add, Radio, x10 vRad2 gRadio_Label, Blue
Gui, Add, Radio, x10 vRad3 gRadio_Label, Green
Gui, Add, Radio, x10 vRad4 gRadio_Label, Red

Gui, Show, w500 h500, Gui
Gui, Submit, Nohide

Return

GuiEscape:
; Fall thru

GuiClose:
Exitapp

Radio_Label:
Gui, Submit, Nohide
If (Rad1 == 1)
   Gui, Color, White
else If (Rad2 == 1)
   Gui, Color, Blue
else If (Rad3 == 1)
   Gui, Color, Green
else If (Rad4 == 1)
   Gui, Color, Red
  
Return