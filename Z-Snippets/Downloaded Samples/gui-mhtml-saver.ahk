Gui, -Caption +Border
Gui, Margin, 0, 10
 
Gui, Add, Progress, w520 h25 x0   y0    Background8F8F8F Disabled hwndHPROG
Control, ExStyle, -0x20000,, ahk_id %HPROG%
 
Gui, Font, s11 Bold
Gui, Add, Text,     w520 h25 x0   y0    gGUIMOVE CFFFFFF BackgroundTrans Center 0x200, MHTMLSaver
Gui, Font
Gui, Add, Text,              x10  y+15, URL to save in MHTML:
Gui, Add, Edit,     w500 h17 x10        vEdit1 -E0x200 +Border
Gui, Add, Text,     w500          y+10  vText1 C0000FF, URL will be saved in <%A_ScriptDir%\url.mht>
Gui, Add, Text,     w250          y+15  vText2   
Gui, Add, Button,   w50  h20 x+35       +0x8000, Browse
Gui, Add, Button,   w50  h20 x+5        +0x8000, Save
Gui, Add, Button,   w50  h20 x+5        +0x8000, Reset
Gui, Add, Button,   w50  h20 x+5        +0x8000, Close
 
Gui, Show, AutoSize, MHTMLSaver
Return
 
 GUIMOVE:
    PostMessage, 0xA1, 2
    Return
;GUIMOVE

GuiEscape:
; Fall Thru

GuiCancel:
; Fall Thru

GuiClose:
Gui, destroy
ExitApp

 