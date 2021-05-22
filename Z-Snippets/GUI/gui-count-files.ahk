
SourceFolder = D:\Richard\My Documents\Google Drive\Games\Notes
TargetFolder = E:\xxx

; Not giving it a width allows it to be as wide as the variable 
Gui, font, s10, Arial
Gui, Add, Text, x10 y10 , Confirm copy from:
Gui, Add, Text, x20 y35 , %SourceFolder%
Gui, Add, Text, x10 y60, Copy to:
Gui, Add, Text, x20 y85 , %TargetFolder%
Gui, Add, Button, x10 y120 w70 h22 default, Ok
Gui, Add, Button, x90 y120 w70 h22 , Cancel
guicontrol, , Minecraft Launcher RES, 1
Gui, Show, x400 y200 h160 , Minecraft Launcher RES
Return

GuiEscape:
; fall through

GuiClose:
; fall through

ButtonCancel:
Gui, Cancel           ; Hide without saving control's contents to their variables
gui, Destroy
ExitApp

buttonOk:
Gui, submit, NoHide
Gui, destroy

; Count files in source folder
count1 = 0

loop, %SourceFolder%\*.*, 1, 1
{
	count1 += 1
}

; Display count results
if count1 > 0 
   msgbox, %SourceFolder% Filecount-1 Total: %count1%
else
   msgbox, 0, ,No files found

exitapp
