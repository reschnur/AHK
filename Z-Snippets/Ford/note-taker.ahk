; note taker

NotesFile = C:\Users\rschnur2\Desktop\Notes.txt
	
^!Q::   ; ctrl-alt-q

; Ask which email is being sent
Gui, font, s10, Arial

Gui, Add, Text,   x10  y10 , Enter Note text:
Gui, Add, Edit,   x10  yp+20  w360 r14 h160 vnotetext, default note text
Gui, Add, Button, x10  y270 w70  h22 default, Ok
Gui, Add, Button, x90  yp w70  h22 , Cancel
Gui, Add, Button, x170 yp w90  h22 gOpenNotes, Open Notes

guicontrol, , Note Taker, 1

Gui, Show, autosize center, Note Taker ; x400 y200 h340 w380, Note Taker
Return

GuiEscape:
Gui, Destroy
return

GuiClose:
gui, Destroy
return

ButtonCancel:
gui, Destroy
return

buttonOk:
Gui, Cancel
Gui, submit, NoHide
Gui, destroy

; Format the time-stamp.
TimeStamp=%A_MM%/%A_DD%/%A_YYYY%, %A_Hour%:%A_Min%

; Write this data to the notes.txt file.
fileappend, %TimeStamp% `n%notetext%`n`n, %NotesFile%

return


OpenNotes:

run, %NotesFile%

return