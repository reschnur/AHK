#SingleInstance, Force

x1 := 10
y1 := 10
w1 := 100
h1 := 40

Gui, Add, Button, x%x1% y%y1% w%w1% h%h1% vBtn1 gMoving_button, Press Me!

Gui, Color, Black

Gui, Show, w500 h500, Gui

Return

GuiEscape:
; Fall thru

GuiClose:
Exitapp

Moving_Button:

; Move the button once when pressed

;x1 += 50
;y1 += 50
;w1 += 20
;h1 += 5

;GuiControl, Move, Btn1, x%x1% y%y1% w%w1% h%h1%
  
;Return


; Move and resize the button repeatedly after the initial press

Loop
{
Loop 6
{
y1 += 2
w1 += 2
h1 ++
GuiControl, Move, Btn1, y%y1% w%w1% h%h1%
GuiControl, Hide, Btn1
GuiControl, Show, Btn1
Sleep, 22
}
}
Return
