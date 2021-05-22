
Gui, Default

Gui, Add, ListView, W600 H500 Checked Grid -Sort vMylistview gListLabel -Multi, Title|Artist

Loop, 5
	LV_Add("Check","Title " . A_Index,"Artist " . A_Index)        ;Fake listview items

LV_ModifyCol()

Gui, Add, Button, getChecked, Submit

Gui, show
return


ListLabel:
return

ListGUIClose:

ListGUIEscape:
ExitApp

etChecked:

CheckedRows =
RowNumber = 0  ; This causes the first loop iteration to start the search at the top of the list.

Loop
{
    RowNumber := LV_GetNext(RowNumber, "Checked")  ; Resume the search at the row after that found by the previous iteration. Could alos be abbreviated to C, but Checked is unambiguous.
    if not RowNumber                               ; The above returned zero, so there are no more selected rows.
        break
	gosub, process	
    CheckedRows .= CheckedRows ? "," RowNumber : RowNumber 
}
msgbox % " Rows " CheckedRows " are Checked"   ; % offsets the other

return

process:

msgbox, process
return