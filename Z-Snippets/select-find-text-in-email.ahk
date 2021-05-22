; This script will search an email for a text string and then extract it to put in a reply email.
; All of the {key} commands are nvigation within the various windows
; This was originally developed for the bulkmail utility

#SingleInstance force              ; Disables pop-up message for re-running this script
SetTitleMatchMode, 2               ; "Window Title Text" can be anywhere in the title

; Activate the email window
WinActivate, Subscribe Request for
WinWaitActive, Subscribe Request for

; Position in body of email
send {tab 3}
send {ctrl}{home}

; Find the sub string
send ^f                           ; open find window
send please                       ; type the search string
send !f                           ; execute the find
sleep 100
send {escape}                     ; exit find window
;KeyWait, LAlt, D                  ; Wait for the left Alt key to be logically released.

setkeydelay, 50

clipboard = 
send {ctrl down}{right}{ctrl up}   ; Skip to next word
; KeyWait, LAlt, D                 ; Wait for the left Alt key to be logically released.
send {shift down}{right 2}{shift up}
send ^c
; clipwait
action := clipboard
; msgbox, action = %action%

clipboard = 
send {home}
send {ctrl down}{right 2}{ctrl up}
send {shift down}{right 8}{shift up}
send ^c 
; clipwait
cds := clipboard
; msgbox, cds = %cds%
   
; Pass focus to the To field of the email
send {ctrl down}{home}{ctrl up}
send {shift down}{tab 3}{shift up}
send %cds%

; Pass focus to the CC field
send {tab 2}
send mshelt29; mconmack

; Pass focus tot he email body
send {tab 4}
send {ctrl down}{home}{ctrl up}


if action = Un
   {
   msgbox, "Unsubscribe " %csd%
   send You have been unsubscribed from the requested list.
   }
else
   {
   msgbox, "Subscribe " %cds%
   send You have been subscribed to the requested list.
   }

exitapp