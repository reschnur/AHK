; Create the ListView with two columns, Name and Size:

; colors names: black silver gray white maroon red purple fuschia green lime olive yellow navy blue teal aqua
; color can also be RGB c9c9c9

; cred below is the font color. same rules apply for color names or codes.
;    colors text only not the title row.
; hdr can be -hdr to not show it
; r20 is the initial number of rows (not all may be filled)
; Sort option sorts on column 1 SortDesc sorts descending

; defeault is readonly rows - readonly allows editing of the rows with wantf2

Gui, Add, ListView, backgroundnavy cwhite grid -readonly wantf2 checked hdr r20 w700 gMyListView, Name|Size (KB)

; Read file names in a folder add each name as a ListView line item
Loop, G:\Games\Minecraft\Worlds\Waypoints\backup\*.* 
    LV_Add("", A_LoopFileName, A_LoopFileSizeKB)

LV_ModifyCol()              ; Auto-size each column to fit its contents.
LV_ModifyCol(2, "Integer")  ; For sorting purposes, indicate that column 2 is an integer.

; Display the window and return. The script will be notified whenever the user double clicks a row.
Gui, Show
return


MyListView:
if A_GuiEvent = DoubleClick
{
    LV_GetText(RowText, A_EventInfo)          ; Get the text from the row's first field.
    ToolTip You double-clicked row number %A_EventInfo%. Text: "%RowText%"
}
return

GuiClose:  
gui, Destroy
ExitApp

GuiEscape:
Gui, Destroy
exitapp


