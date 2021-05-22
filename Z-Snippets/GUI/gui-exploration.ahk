; This example was originally part of the bulkmail utility to ask why the request was not valid 
; and send appropriate text to the form

#SingleInstance force            ; Disables pop-up message for re-running this scipt
SetTitleMatchMode, 2             ; 1 = begins with, 2 = anywhere, 3 = exact match


Gui, font, s12 000000 Bold Italic, Courier New
Gui, +LastFound
; winset, transcolor, 180

Gui, color, 00ff000
Gui, Add, Radio, x10 y10 checked vRadioFP, Invalid LL4+ Approver
Gui, Add, Radio, x10 y32 vRadioSP, Already List Manager
Gui, Add, Radio, x10 y54 vRadioXP , Invalid CDS ID
Gui, Add, Button, x10 y80 w70 h22 default, Ok
Gui, Add, Button, x90 y80 w70 h22 , Cancel

Gui, Show, x400 y200 h110 w300, GUI Explore
gui, - Caption

Return

GuiEscape:
; Fall thru


GuiClose:
; Fall thru


ButtonCancel:
gui, Destroy
exitapp

buttonOk:
Gui, Cancel
Gui, submit, NoHide
Gui, destroy

exitapp

winactivate, Service Manager
;WinWaitActive, Service Manager

; Find the text field on the form
Send ^f
Send Is this a Valid Request?{Enter}{Escape}

; Set focus on the form for entering the text
Send {Tab}{Right}{Tab}	

; Fill the request form field

If (RadioFP=1) ; If no selection is made then button 2 is assumed (the else) so the process can continue
{
	; msgbox, Button 1
    Send The provided LL4{+} CDSID is not valid. This request is rejected.
}
Else 
{
	; msgbox, Button 2
    Send The requested person is already a list manager. No action was necessary.
}
exitapp