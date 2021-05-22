; Open two windows and park them on each side of the monitor

; 1 = must start with; 2 = anywhere; 3 = exact
SetTitleMatchMode, 3 

SysGet, MonitorWorkArea, MonitorWorkArea
;MsgBox, "Work Area: " %MonitorWorkArea%0


; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

openfolder1 := "D:\Richard\OneDrive\Games\Minecraft Downloads"

IfExist, %openfolder1%
   runwait, explore %openFolder1%
else
   MsgBox, The specified folder %openfolder1% does not exist.
   
winactivate, %openfodler1%
winwaitactive, %openfolder1%   
;                title text    x  y                       w                      h
WinMove, %openfolder1%,    ,   0, 0,(MonitorWorkAreaRight), (A_ScreenHeight * .44)
WinGetPos, X, Y, Width, Height, A

; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  
openfolder2 := "D:\Richard\OneDrive\Games\Minecraft Profiles"

IfExist, %openfolder2%
   runwait, explore %openFolder2%
else
   MsgBox, The specified folder %openfolder2% does not exist.
winactivate, %openfolder2%   
winwaitactive, %openfolder2%   
;                title text  x                       y                      w                        h
WinMove, %openfolder2%,    , 0, (A_ScreenHeight * .435), (A_ScreenWidth * .464), (A_ScreenHeight * .498) 


; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   
openfolder3 := "C:\Users\resch\AppData\Roaming"

IfExist, %openfolder3%
   runwait, explore %openFolder3%
else
   MsgBox, The specified folder %openfolder3% does not exist.

winactivate, %openfolder3%   
winwaitactive, %openfolder3%   
;                title text                     x                        y                     w                        h
WinMove, %openfolder3%,    , (A_ScreenWidth * .4575), (A_ScreenHeight * .435), (A_ScreenWidth * .467), (A_ScreenHeight * .498) 
