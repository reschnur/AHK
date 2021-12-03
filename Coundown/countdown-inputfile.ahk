#Persistent

ScriptName = Countdown

Start:

; Read record 1
FileReadLine, CountDate, C:\Users\rschnur2\Desktop\countdown.txt, 1

if CountDate = ~  ; Do not use the %-% format. Will not work.
   {
   MsgBox, 0, %Script_Name%, Bypass countdown., 1
   exitapp
   }

date = %CountDate%
Date:=SubStr(Date,1,8) SubStr(A_Now,9)

; msgbox, 0, Counter, Date: %date%

; Read record 2
FileReadLine, CountReason, C:\Users\rschnur2\Desktop\countdown.txt, 2

; msgbox, 0, Counter, Reason:`n %countreason%

now:=A_Now

Loop
   If (now>=Date){
      ; MsgBox,262208,Countdown,Cruise is in %A_Index% Days., 4 ; 262144 = always on top + 64 for icon
	  gosub displaytime
      break
   } else now+=1,d

;SetTimer,Start,% 24*60*60*1000 ; remind again in 24 hours in case user does not logoff

return

; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


displaytime:

gui, new,,Countdown
gui, font, s30, Verdana  ; Set 10-point Verdana.
Gui, Color, c9c9c9

Gui, Add, Text, cBlack x10 , %CountReason% in %a_index% days.         ; h50 y80 w220
; Gui, Add, Text, cBlack x10 , in %a_index% days. ; h50 y25 w220

gui, font, s10, Verdana  ; Set 10-point Verdana.
Gui, Add, Button, w80 h30 Default, &OK ; x60 y160

gui, +alwaysontop +owner ; +owner = no taskbar icon

Gui, Show, autosize center ; w260 ; h200, AHK-Scheduler

; winactivate, 

Return

GuiEscape:
; fall thru

GuiClose:
; fall thru

ButtonCancel:
; fall thru

ButtonOK:
Gui, destroy

ExitApp  ; All of the above labels will do this.
  
; return
