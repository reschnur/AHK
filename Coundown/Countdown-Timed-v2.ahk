; Display a timed GUI window with "days until" base don a file of parameters

Script_Name = Countdown
DisplayTime = 6000             ; Milliseconds

; Read record 1 from file - date of event
FileReadLine, EventDate, C:\Users\rschnur2\Desktop\countdown.txt, 1

; Check for bypass trigger
if EventDate = ~                       ; Do not use the %-% format. Will not work.
   {
   MsgBox, 0, %Script_Name%, Bypass countdown., 1
   exitapp
   }

; Read record 2 from file - Event name
FileReadLine, CountReason, C:\Users\rschnur2\Desktop\countdown.txt, 2


NbrOfDays  = %EventDate%
NbrOfDays -= %A_Now%, days
; MsgBox, There are %NbrOfDays% days between %A_Now% and %EventDate% using subtract
	  
gosub DisplayTime

exitapp


; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

DisplayTime:

gui, new,,Countdown
Gui, Color, c9c9c9
gui, font, s38, Verdana

Gui, Add, Text, center cBlack x10 ,%CountReason% in %NbrOfDays% days.         ; a_index is from the loop above that counts the days.

gui, font, s10, Verdana      ; Reset font to normal values

gui, +alwaysontop +owner     ; +owner = no taskbar icon

Gui, Show, autosize center, %Script_Name%


sleep, %DisplayTime%         ; How long to display in milliseconds

exitapp                      ; exitapp will destroy the gui and then exit


GuiEscape:
exitapp

GuiClose:
exitapp