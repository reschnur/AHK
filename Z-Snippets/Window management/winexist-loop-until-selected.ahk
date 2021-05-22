#SingleInstance force ; Disables pop-up message for re-running this scipt
SetTitleMatchMode, 2 ; "Window Title Text" can be anywhere in the title

; This process will loop until the user opens the needed window, 
; indicates the need to not process what this window is for or 
; selects to cancel the remaining process steps.

boxtitle = Winexist-sample
process = false_val
window_name = SA IOM Client

loop    ; loop continuously until an action forces an exit from it
{
; Window was opened from the received email
IfWinExist, %window_name%
   {
   msgbox, 0, %boxtitle%-debug, Window is present. Good-to-go.
   process = true_val
   break   ; exit the loop so the process can go on to the email process
   }
else
   {
   MsgBox, 51, %boxtitle%-debug, No %window_name% window was found. `n`nDo you wish to proceed?`n`nSelect a window and click Yes to continue, `nClick No to skip this step and got to the email step, `nClick Cancel to stop processing this request.
   winactivate, Error
   ifmsgbox, yes
	 continue   ; start over
	 ifmsgbox, no
	    {
	    process = false_val
        break ; exit the loop so the process can go on to the email process
	    }
 	 ifmsgbox, cancel
	    exit   ; exit the process for this request - NO MESSAGE WILL BE DISPLAYED
     }
}

if process = true_val
   msgbox, %boxtitle%-debug, Window found and processing continues.
else 
   msgbox, %boxtitle%-debug, This step in the process skipped. 