; Build a ListView where you can add rows dynamically

#SingleInstance, Force
SetTitleMatchMode, 2                   ; 1 = Begins with, 2 = Anywhere, 3 = Exact

Script_Name = Dynamic Checkboxes


RowCount = 0

Gui, Add, ListView, r10 AltSubmit Checked v#HSList Hdr gListViewChecks, |Column

Gui, Add, Button, gAddRow, Add Row

Gui, Show,, Dynamically Add Checkboxes

Return

AddRow:

RowCount += 1

; MsgBox, 0, %Script_Name%, Row Count: %RowCount%, 2

Row_Text := "The is Row " . RowCount     ; Using % causes error . is concatenate.

LV_Add(Checked, "", Row_Text)

Return

ListViewChecks:

If (A_GuiEvent == "I") 
{
    If (ErrorLevel == "C")
        ToolTip, % "Row " . A_EventInfo . " is checked."            ; %
    Else If (ErrorLevel == "c")
        ToolTip, % "Row " . A_EventInfo . " is unchecked."          ; %
}

Return


GuiEscape:
; Fall thru

GuiClose:
ExitApp