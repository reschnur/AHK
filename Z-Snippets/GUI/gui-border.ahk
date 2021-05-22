; Define a gui and only show it when either ctrl key is pressed

#SingleInstance, Force
SetTitleMatchMode, 2                   ; 1 = Begins with, 2 = Anywhere, 3 = Exact

BorderThickness:=4, BorderColor:="ff0000",  TW:=320, TH:=240

;                            x,                 y
Gui, Margin, %BorderThickness%, %BorderThickness%

Gui, Color, %BorderColor%

Gui, Add, Text, w%TW% h%TH% 0x6 ; 0x6 = Draw a rectangle filled with current background color

Gui +LastFound                  ; Set status so WinSet command functions correctly                

WinSet, TransColor, FFFFFF

Gui -Caption +AlwaysOnTop +ToolWindow   ; ToolWindow = small title, but no buttons

Return

~Control::
  
  Gui, Show, NoActivate      ; The Gui will not steal keyboard focus (NoActivate)
  
  Loop {                     ; Wait until Control key is released
        If Not GetKeyState( "Control", "P" )
        Break
        Sleep 50
       } 
  
  Gui, Hide

  Return