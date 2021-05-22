;

#SingleInstance, Force
SetTitleMatchMode, 2                   ; 1 = Begins with, 2 = Anywhere, 3 = Exact

Gui, +AlwaysOnTop

Gui, Color, black
Gui, Font, cWhite, s22

; y is .75 of the font so items with same y amy need adjusting for proper alignment
; x = 1.25 of font for first control
; x+10 starts from end positon
; xp+10 strats from start position
; Negative values will move the item up (y) or left (x)

; xm/ym says put them at the margin
Gui, Margin, 50, 100
Gui, Add, Button, xm ym w100 h30, Here One

Gui, Margin, 10, 10
; no x uses default margin
Gui, Add, Button, ym w100 h30, Here Two

; x+20 will start from end of prior control
Gui, Margin, 10, 10
Gui, Add, Button, x+20 ym w100 h30, Here Three

; will overlap previous button because xp starts from start of prior control
Gui, Margin, 10, 10
Gui, Add, Button, xp+20 ym w100 h30, Here Four

; will overlap previous button because xp starts from start of prior control
; It will also be shifted tot he left of the previous button
Gui, Margin, 10, 10
Gui, Add, Button, xp-20 ym, Here Five

; will overlap previous button and be to the left of it because xp starts from start of prior control
; It will be off the left edge of the window.
Gui, Margin, 10, 10
Gui, Add, Button, x-20 ym, Here Six

; hard x/y
Gui, Add, text, x10 y200 border, Here Text.
Gui, Show, x700 y500 w600 h600

Return

GuiEscape:
GuiCloese:
ExitApp