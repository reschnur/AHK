; Open three windows and park them one on top and two side-by-side on the bottom.
; The top window is full width and the bottom ones are half width.

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
   
winactivate, %openfolder1%
winwaitactive, %openfolder1%   
;                title text    x  y                       w                      h
WinMove, %openfolder1%,    ,   0, 0,(MonitorWorkAreaRight), (A_ScreenHeight * .44)
WinGetPos, XPos1, YPos1, Width1, Height1, A

/*
MsgBox, 
(
XPos:   %XPos%
YPos:   %YPos%
Width:  %Width%
Height: %Height%
)
*/

; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  
openfolder2 := "D:\Richard\OneDrive\Games\Minecraft Profiles"

IfExist, %openfolder2%
   runwait, explore %openFolder2%
else
   MsgBox, The specified folder %openfolder2% does not exist.
winactivate, %openfolder2%   
winwaitactive, %openfolder2%   
;                title text  x         y                      w                        h
WinMove, %openfolder2%,    , 0, (Height1 - 7), (A_ScreenWidth * .464), (A_ScreenHeight * .498) 
WinGetPos, XPos2, YPos2, Width2, Height2, A


; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   
openfolder3 := "C:\Users\resch\AppData\Roaming"

IfExist, %openfolder3%
   runwait, explore %openFolder3%
else
   MsgBox, The specified folder %openfolder3% does not exist.

winactivate, %openfolder3%   
winwaitactive, %openfolder3%   
;                title text             x              y             w         h
WinMove, %openfolder3%,    , (Width2 - 10), (Height1 - 7), (Width2 - 5), (Height2 + 5)