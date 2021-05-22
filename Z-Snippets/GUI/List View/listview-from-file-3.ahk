;


; Load world anems to array


Gui,Add,ListView,r20 backgroundteal cwhite grid gMyListView,World Name

Loop,Read,G:\Games\Minecraft\Mods & Tools\2-AHK Scripts\Minecraft RES Tool Suite\world-names-desktop.txt
{
	StringSplit, var_,A_LoopReadLine,~;

	LV_Add("",var_1) ;,var_2,var_3,var_4,var_5,var_6) ;.... you will need to add as many as you have columns (up to 253 parameters possible)
    LV_ModifyCol()  ; Auto-size each column to fit its contents.
}

Gui,Show

Return

GuiClose:

ExitApp

MyListView:

RowNumber = 0                            ; This causes the first loop iteration to start the search at the top of the list.

Loop
{
    RowNumber := LV_GetNext(RowNumber)  ; Resume the search at the row after that found by the previous iteration. This method assumes checked.
    if not RowNumber                    ; The above returned zero, so there are no more selected rows.
        break
    
	LV_GetText(Text, RowNumber)
	
	; row number equates to array value and array contains the corresponding world path.
	; Write text box to corresponding file.
    
	MsgBox The next selected row is #%RowNumber%, whose first field is "%Text%".
}

MsgBox, 0, %Script_Name%, Done, 2

exitapp