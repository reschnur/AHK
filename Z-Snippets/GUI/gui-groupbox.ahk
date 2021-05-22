;

#SingleInstance, Force
SetTitleMatchMode, 2                   ; 1 = Begins with, 2 = Anywhere, 3 = Exact

; Group box
; 0x300 = center text horizontally
; 0x2000 = wrap text
; 0x8000 = flat


; Text
; 0x1 = Add simple rectangle
; 0x200 = centered vertically
; 0x201 = centered horizontally
; 0x8000 = flat

Gui, Margin, 50, 20
Gui, Color, White

; Style 1 - pseudo groupbox - must be in this order because of x/y
; Box
Gui, Add, Text,             w300 h100 +E0x1 +E0x200                             ; WS_EX_DLGMODALFRAME=0x1, WS_EX_CLIENTEDGE=0x200
; Header
Gui, Add, Text, xp+20 yp-10 w100 h30  +E0x1 +E0x200 0x201 cBlue, GroupBox 1
 
; Style 2
Gui, Add, GroupBox, xm w300 h50 0x300 0x8000 cFE6086, GroupBox 2
 
; Style 3
Gui, Add, GroupBox, xm w300 h50 cFE6086
Gui, Add, Progress, xp+20 yp-3 w100 h20      BackgroundGreen                         ; fake a background to color the heading
Gui, Add, Text,     xp         wp   hp 0x201 BackgroundTrans cYellow, GroupBox 3
 
Gui, Show
Return

GuiEscape:
; Fall thru
 
GuiClose:
ExitApp