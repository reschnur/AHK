#Persistent

Start:

;                                                       w    h    x    y      default
InputBox, UserInput, Countdown Timer, Target Date:, , 180, 130, 100, 100, , , 20190310
if ErrorLevel
   {
   ; MsgBox, CANCEL was pressed.
   exitapp
   }
else
   {
   ; MsgBox, You entered "%UserInput%"
   }

date := %userinput%
Date:=20190310
Date:=SubStr(Date,1,8) SubStr(A_Now,9)

; msgbox, %date%

now:=A_Now

Loop
   If (now>=Date){
      MsgBox,262208,Countdown,Cruise is in %A_Index% Days., 4 ; 262144 = always on top + 64 for icon
      break
   } else now+=1,d

SetTimer,Start,% 24*60*60*1000 ; remind again in 24 hours in case user does not logoff