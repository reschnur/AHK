; Display a GUI window with a value for a set amount of time

Script_Name = Countdown

; Read record 1 from file - date of event
FileReadLine, CountDate, C:\Users\rschnur2\Desktop\countdown.txt, 1

; Check for bypass trigger
if CountDate = ~                       ; Do not use the %-% format. Will not work.
   {
   MsgBox, 0, %Script_Name%, Bypass countdown., 1
   exitapp
   }

Date = %CountDate%
MsgBox, 0, %Script_Name%, %Date%, 2
Date:=SubStr(Date,1,8) SubStr(A_Now,9)
MsgBox, 0, %Script_Name%, %Date%, 2

; Read record 2 from file - Event name
FileReadLine, CountReason, C:\Users\rschnur2\Desktop\countdown.txt, 2


now := A_Now
MsgBox, 0, %Script_Name%, %Now%, 2

; Count the days - each iteraton adds 1 to A_Index and "now"
; Once "now" is >= to the event date the GUI is displayed.
; A_Index becomes the number of days from today until the event date

Loop
{
   If (now>=Date)
      {
	  NbrOfDays = %A_Index%                                     ; Current index is days until the event
	  
	  gosub displaytime
      
	  break
      } 
   else 
      now += 1, d                                              ; d = days
}

return


; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


displaytime:

; Create the GUI
gui, new,,Countdown
gui, font, s40, Verdana
Gui, Color, c9c9c9

Gui, Add, Text, center cBlack x10 ,%CountReason% in %NbrOfDays% days.         ; a_index is from the loop above that counts the days.

gui, font, s10, Verdana      ; Reset font to normal values

gui, +alwaysontop +owner     ; +owner = no taskbar icon

; Show the GUI and force to top of any other windows
Gui, Show, autosize center 
winactivate, Countdown

sleep, 6000                  ; How long to display in milliseconds

exitapp                      ; exitapp will destroy the gui and then exit