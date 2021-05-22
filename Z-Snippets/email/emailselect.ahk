#SingleInstance force ; Disables pop-up message for re-running this scipt

SetTitleMatchMode, 2 ; "Window Title Text" can be anywhere in the title


emailaddress:

loop
{
IfWinExist, Bulkmail Access Request ; Email is open
{
;    msgbox, 4,,Email Open
	WinActivate, Bulkmail Access Request
	; WinActivate, Bulkmail Access Request
    WinWaitActive, FW
	break
}
else
{
;    msgbox, 4,,Service Request Mail is not open, activate Outlook
;	ifmsgbox, no
;	   exitapp
; Switch to Outlook Inbox and select Forward for the selected email
	WinActivate, Inbox ; Perhaps email is selected in Outlook
	WinWaitActive, Inbox
	Send ^f     ; ^f = key sequence for forwarding the email selected in the list
	WinWaitActive, FW
}

IfWinNotActive, Bulkmail Access Request ; Email wasn't selected in Outlook
{
	WinClose, FW
	MsgBox, 48,, Error - The Request Center email is not the selected email in the list.`nThe request response email cannot be created. `nPlease seelct the Request Center email, select forward and try again.
;	Exit
}
}

; Position message for better reading
WinMove, %WinTitle%,, 0, 0, (A_ScreenWidth/2), (A_ScreenHeight * .93)

exitapp