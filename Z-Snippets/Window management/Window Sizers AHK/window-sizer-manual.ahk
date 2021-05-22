#SingleInstance force ; Disables pop-up message for re-running this scipt

; 1 = must start with; 2 = anywhere; 3 = exact
SetTitleMatchMode, 2 

;               x y w                     h
^!z::WinMove,A,,0,0,(A_ScreenWidth * .875), (A_ScreenHeight * .915)
