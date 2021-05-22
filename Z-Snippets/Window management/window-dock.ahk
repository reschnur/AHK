; Open two windows and park them on each side of the monitor

; 1 = must start with; 2 = anywhere; 3 = exact
SetTitleMatchMode, 3 

openfolder1 := "G:\Off Load"

IfExist, %openfolder1%
   runwait, explore %openFolder1%
else
   MsgBox, The specified folder %openfolder1% does not exist.
   
   
openfolder2 := "G:\Off Load\personal"

IfExist, %openfolder2%
   runwait, explore %openFolder2%
else
   MsgBox, The specified folder %openfolder2% does not exist.

   
winactivate, %openfodler1%
winwaitactive, %openfolder1%   
;               title text    x  y                    w                        h
WinMove, %openfolder1%,    ,   0, 0,(A_ScreenWidth * .5), (A_ScreenHeight * .945)


winactivate, %openfolder2%   
winwaitactive, %openfolder2%   
;               title text                    x   y                     w                        h
WinMove, %openfolder2%,    , (A_ScreenWidth * .5), 0, (A_ScreenWidth * .5), (A_ScreenHeight * .945) 
