;

#SingleInstance, Force
SetTitleMatchMode, 2                   ; 1 = Begins with, 2 = Anywhere, 3 = Exact

Gui, 1:+AlwaysOnTop
Gui, 1:Color, 222222, Black
Gui, 1:Font, cGray Underline, Cooper Black 

Gui, 1:Add, Edit, x10 y10 w200 r1 vLast_Name_Edit gSubmit_All, ;% temp_last_name_Edit ; %
Gui, 1:Add, Edit, x10     w200 r1 vFirst_Name_Edit gSubmit_All, ;% temp_first_name_Edit ; %

Gui, 1:Font,                            ; Resent font settings
Gui, 1:Font, cWhite, Segoe UI
Gui, 1:Add, Button, x10 w200 h30 gReload, Reload

Gui, 1:Add, Edit, x10 w200 r2 ReadOnly vDisplay_Edit, % Last_Name_Edit "'n" First_Name_Edit  ; %

GuiControl, 1:Focus, Display_Edit

Gui, 1:Show, w220 h150

Return


GuiEscape:
GuiClose:
   ExitApp

Submit_All:
   Gui, 1:Submit, NoHide                                                   
   GuiControl, 1:,Display_Edit, % First_Name_Edit "`n" Last_Name_Edit
   Return

Reload:
   Reload