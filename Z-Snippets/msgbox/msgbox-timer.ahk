SetTitleMatchMode, 2    ; 1 = start with, 2 = anywhere, 3 = exact match

; You need to play with the delay "100"
SetTimer, WinMoveMsgBox, 100

MsgBox, 4132, Decrease Latency, More? 

; ExitApp

Return

WinMoveMsgBox:

SetTimer, WinMoveMsgBox, OFF

;ID:=WinExist("Decrease Latency")

WinMove, Decrease, , 1200, 500 

Return