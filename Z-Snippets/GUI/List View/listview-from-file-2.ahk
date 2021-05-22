; Create a ListView from a file

; colors names: black silver gray white maroon red purple fuschia green lime olive yellow navy blue teal aqua
; color can also be RGB c9c9c9

; cred below is the font color. same rules apply for color names or codes.
;    colors text only not the title row.
; hdr can be -hdr to not show it
; r20 is the initial number of rows (not all may be filled)
; Sort option sorts on column 1 SortDesc sorts descending

; default is readonly rows - readonly allows editing of the rows with wantf2

WorldNamesFile = G:\Games\Minecraft\Mods & Tools\2-AHK Scripts\Minecraft RES Tool Suite\world-names-desktop.txt

Gui, Add, ListView, backgroundteal cwhite grid -readonly wantf2 checked hdr r20 w700 gMyListView, Name
Gui, Font, s14

Loop, read, %WorldNamesFile%

{
    Loop, parse, A_LoopReadLine, ~ ; %A_Tab%
    {
        ; MsgBox, Field number %A_Index% is %A_LoopField%.

		LV_Add("", A_LoopField)

        LV_ModifyCol()  ; Auto-size each column to fit its contents.

    }
}
Gui, Add, Button, h25 w80 default xm, OK 

; Display the window and return. The script will be notified whenever the user double clicks a row.
Gui, Show
return

ButtonOK:

Gui, Submit
gosub MyListView

GuiEscape:
Gui, Destroy
exitapp

GuiClose:
gui, Destroy
exitapp


MyListView:

RowNumber = 0                            ; This causes the first loop iteration to start the search at the top of the list.

Loop
{
    RowNumber := LV_GetNext(RowNumber)  ; Resume the search at the row after that found by the previous iteration. This method assumes checked.
    if not RowNumber                    ; The above returned zero, so there are no more selected rows.
        break
    
	LV_GetText(Text, RowNumber)
    
	MsgBox The next selected row is #%RowNumber%, whose first field is "%Text%".
}

MsgBox, 0, %Script_Name%, Done, 2

exitapp