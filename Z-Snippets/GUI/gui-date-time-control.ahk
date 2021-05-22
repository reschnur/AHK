; Ask for a date and then count down to it displaying a msgbox each day until the date arrives

#SingleInstance, Force
#Persistent

Gui, Add, Text, x10 y15 w90 h20, Select target date:
Gui, Add, DateTime, x+10 y10 wp20 h20 vdate1 Section,

Gui, Add, Button, x10 y50 w60 h20 Default, &Start

Gui, Show, w230 h90, Countdown

Return


ButtonOK:

Gui, submit, nohide
  
FormatTime, date2, %date1%, yyyyMMdd

MsgBox, Date1: %date1% - Date2: %date2%

start:

;Date:=%date%

; Build a valid timestamp frpom the selected date (add the current time)
Date3: = SubStr(%date2%,1,8) SubStr(A_Now,9)
msgbox, Date3: %date3%

now:=A_Now

Loop
   If (now>=Dates3){
      MsgBox, 262144, Countdown, Cruise is in %A_Index% Days., 4
      break
   } else now+=1,d    ; Add 1 day

SetTimer,Start,% 24*60*60*1000 ; remind again in 24 hours in case user does not logoff  ; %

return

GuiEscape:
; Fall thru

GuiClose:
ExitApp                            ; Terminate including if persistent
