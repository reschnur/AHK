#SingleInstance, force
SetTitleMatchMode, 2

; Create the ListView

; color names: black silver gray white maroon red purple fuschia green lime olive yellow navy blue teal aqua
; color can also be RGB c9c9c9

; c option below is the font color. same rules apply for color names or codes.
;    colors text only not the title row.
; hdr can be -hdr to not show it
; r option below is the initial number of rows (not all may be filled), as shown it can also be a variable 
; Sort option sorts on column 1 SortDesc sorts descending

; default is readonly rows - readonly allows editing of the rows with wantf2 option

^!p::
RowCount = 1
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Count the number of rows in the file to set the list view row parameter
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Loop, read, C:\shell-commands.txt
    {
	stringleft, pos1, A_LoopReadLine, 1
	if pos1 <> #                               ; # = comment line. Skip the record.
       RowCount ++
    }


; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Build the GUI and do the initial display
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

gui, font, s12, Verdana bold
 
Gui, Add, ListView, backgroundgray cblue grid hdr r%RowCount% w800 gProcessListView, CommandName

; Read the file to build the list view
Loop, read, C:\shell-commands.txt
    {
	stringleft, pos1, A_LoopReadLine, 1
	if pos1 <> #                               ; # = comment line. Skip the record.
       LV_Add("", A_LoopReadLine)
    }
	
LV_ModifyCol()  ; Auto-size each column to fit its contents.

Gui, Add, Button, gOpenCommandFile, Open Command File 

; Display the window and return. 
Gui, Show

return


; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Process the subsequent displays
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
KeyWait Control
KeyWait Alt

; Display the window and return. 
Gui, Show


; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Process the selected command
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
ProcessListView:

if A_GuiEvent = DoubleClick
{
    LV_GetText(RowText, A_EventInfo)  ; Get the text from the row's first field.
	
    ToolTip You double-clicked row number %A_EventInfo%. Text: "%RowText%"
	
	SetTimer, removetooltip, 2000               ; turn off the tool tip after 2 seconds (2000 milliseconds)
	
    msgbox, 0, %script_name%, Make sure the cursor is in the correct position to insert:`n`n%RowText%, 2

    ; Window titles are case sensitive
    if WinExist("MING")
        WinActivate ; use the window found above
    else
        {
        MsgBox, 64, Command Inserter, Window not found!, 2
        return
        }


    Send, %RowText%
}

return


; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Process standard GUI closing actions
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

GuiClose: 
; fall thru

GuiEscape:
Gui, Hide
return


RemoveToolTip:

SetTimer, RemoveToolTip, Off

ToolTip                           ; command with no text turns off the tip window

return


OpenCommandFile:

run, C:\shell-commands.txt

return