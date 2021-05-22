; Open windows and arrange them across the monitors

#SingleInstance force ; Disables pop-up message for re-running this scipt

; 1 = must start with; 2 = anywhere; 3 = exact
SetTitleMatchMode, 2 

path1 = 
path2 = 
path3 =

run, explorer %path1%
winwaitactive, A

;               x y w                     h
^!z::WinMove,A,,0,0,(A_ScreenWidth * .875), (A_ScreenHeight * .915)
