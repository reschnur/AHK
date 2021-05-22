;

#SingleInstance, Force
SetTitleMatchMode, 2                   ; 1 = Begins with, 2 = Anywhere, 3 = Exact

Script_Name = Radio buttons

gui, add, edit,  x15 readonly, Highlight Value

gui, add, radio, x+5 gHighlightValue vHighlightValue,1
gui, add, radio, x+1 gHighlightValue ,2
gui, add, radio, x+1 gHighlightValue ,3
gui, add, radio, x+1 gHighlightValue ,4
gui, add, radio, x+1 gHighlightValue ,5

gui,show

guicontrol, , 3, 1

return

GuiEscape:
; Fall thru

GuiCancel:
; Fall thru

GuiClose:
Gui, Destroy
ExitApp


highlightvalue:

Gui, Submit

MsgBox, 0, %Script_Name%, Process selection
; HighlightValue = 

return