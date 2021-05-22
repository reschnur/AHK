;

#SingleInstance, Force
SetTitleMatchMode, 2                   ; 1 = Begins with, 2 = Anywhere, 3 = Exact


Gui, font, s10, Verdana

Gui, Add, Radio, x10 y10  vRadioFP , Invalid LL4+ Approver
Gui, Add, Radio, x10 y32  vRadioSP , Already List Manager
Gui, Add, Button, x10 y64 w70 h22 default, Ok
Gui, Add, Button, x90 y64 w70 h22 , Cancel

Gui, Show, x400 y200 h100 w300, Page Setup

Return

GuiEscape:
; Fall thru

GuiClose:
; Fall thru

ButtonCancel:

gui, Destroy

exitapp


; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

buttonOk:

Gui, submit, NoHide

MsgBox % "RadioAll: " RadioAll "`nRadioFP: " RadioFP "`nRadioSP: " RadioSP  ; %

If (RadioFP=1)
	msgbox, Run Notepad.exe
Else If (RadioSP=1) 
	msgbox, Run Excel.exe ; etc
else
    msgbox No Selection!

return