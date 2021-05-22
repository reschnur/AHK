#SingleInstance force ; Disables pop-up message for re-running this scipt

; 1 = must start with; 2 = anywhere; 3 = exact
SetTitleMatchMode, 2 

loop
{
ifwinexist, Incident Modification
{
   ;                       title,    x, y, w,   h
   WinMove, Incident Modification,  ,240 , , 480, 610
   msgbox, 65, SVD Sizer, Make sure you check the Resolution Categorization settings `non the Categorization tab on the incident incident home page.
}

ifwinexist, Controls Checklist Update
{
   WinActivate, Controls Checklist Update
   WinWaitActive, Controls Checklist Update
   ;                       title,          x,  y,    w,   h
   WinMove, Controls Checklist Update,  , 100, 100, 1400, 640
}

ifwinexist, Mozilla Firefox
{
   ;                       title,    x, y, w,   h
   WinMove, Mozilla Firefox,  ,0 , 0, (A_ScreenWidth * .89), (A_ScreenHeight * .95)
}

ifwinexist, Insert File
{
   ;                       title,    x, y, w,   h
   WinMove, Insert File,  ,100 , 0, (A_ScreenWidth * .65), (A_ScreenHeight * .9)
}

SetTitleMatchMode, 3
ifwinexist, Open
{
   ;                       title,    x, y, w,   h
   WinMove, Open,  ,100 , 0, (A_ScreenWidth * .65), (A_ScreenHeight * .9)
}

ifwinexist, Save As
{
   ;                       title,    x, y, w,   h
   WinMove, Save As,  ,100 , 0, (A_ScreenWidth * .65), (A_ScreenHeight * .9)
}
SetTitleMatchMode, 2 

ifwinexist, Choose File to Upload
{
   ;                       title,    x, y, w,   h
   WinMove, Choose File to Upload,  ,100 , 0, (A_ScreenWidth * .65), (A_ScreenHeight * .9)
}

ifwinexist, Copy Items
{
   ;                       title,    x, y, w,   h
   WinMove, Copy Items,  ,200 , 100, (A_ScreenWidth * .25), (A_ScreenHeight * .8)
}

ifwinexist, Move Items
{
   ;                       title,    x, y, w,   h
   WinMove, Move Items,  ,200 , 100, (A_ScreenWidth * .25), (A_ScreenHeight * .8)
}

ifwinexist, Select Folder
{
   ;                       title,    x, y, w,   h
   WinMove, Seelct Folder,  ,200 , 100, (A_ScreenWidth * .25), (A_ScreenHeight * .8)
}

; Debug: KeyWait, LAlt, D  ; Wait for the left Alt key to be logically released.
}