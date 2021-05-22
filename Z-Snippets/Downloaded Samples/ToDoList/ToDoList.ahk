;
; AutoHotkey Version: 1.x
; Language:       English
; Platform:       Win9x/NT
; Author:         Jack Dunning, ceeditor@computoredge.com
;
; Script Function: Play audio and video files
; This is the second version of ToDoList.ahk from the AutoHotkey column dated August 2, 2013	
;

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


OnExit, UpdateFile

Gui, default
Gui +AlwaysOnTop +Resize
Gui, Add, ListView, sort r10 checked -readonly vMyListView gMyListView , Items To Do 
Gui, Add, Button, section gAddItem,Add to list
Gui, Add, Edit, ys vNewItem w180 , <Enter New Item Here>

SelectedRow := 0

IfExist, ToDoList.txt
{
Loop, Read, ToDoList.txt
  {
  If (A_index = 1 and SubStr(A_LoopReadLine, 1, 1) = "x")
     {
       WinPos := A_LoopReadLine
       Continue
     }
  If SubStr(A_LoopReadLine, 1, 1) = "*"
    {
     StringTrimLeft, CheckedText, A_LoopReadLine, 1
     LV_Add("Check", CheckedText)
    }
  Else
     LV_Add("", A_LoopReadLine)
  }

}

LV_ModifyCol(1,"AutoHdr")

Menu, MyContextMenu, Add, Edit, EditItem
Menu, MyContextMenu, Add, Delete, DeleteItem
Menu, Tray, Add, Show To Do List, ShowTodo


IfExist, ToDoList.txt
  {
     Gui, Show, %WinPos% , To Do List
  }
Else
  {
     WinGetPos,X1,Y1,W1,H1,Program Manager
     X2 := W1-300
     Gui, Show, x%x2% y50 , To Do List
  }

 
Hotkey, ^!t, ShowTodo
Return

ShowTodo:
Gui, Show,, To Do List
Return

MyListView:
  If A_GuiEvent = e
    UpdateFile()
Return

GuiContextMenu:  ; Launched in response to a right-click or press of the Apps key.
if A_GuiControl <> MyListView  ; Display the menu only for clicks inside the ListView.
    return

  LV_GetText(EditText, A_EventInfo) 
; Show the menu at the provided coordinates, A_GuiX and A_GuiY.  These should be used
; because they provide correct coordinates even if the user pressed the Apps key:
Menu, MyContextMenu, Show , %A_GuiX%, %A_GuiY%
return


DeleteItem:  ; The user selected "Clear" in the context menu.
RowNumber = 0  ; This causes the first iteration to start the search at the top.

Loop
{
    ; Since deleting a row reduces the RowNumber of all other rows beneath it,
    ; subtract 1 so that the search includes the same row number that was previously
    ; found (in case adjacent rows are selected):
    RowNumber := LV_GetNext(RowNumber - 1)
    if not RowNumber  ; The above returned zero, so there are no more selected rows.
        break
    LV_Delete(RowNumber)  ; Clear the row from the ListView.
}
UpdateFile()
return

AddItem:
  Gui, Submit, NoHide

If SelectedRow = 0
{
  LV_Add("", trim(NewItem))
}
else
{
  LV_Modify(SelectedRow,"",Trim(NewItem))
  SelectedRow := 0
  GuiControl, ,Button1, Add to list
}
  UpdateFile()
  LV_ModifyCol(1,"AutoHdr")
Return

EditItem:
  SelectedRow := LV_GetNext()
  GuiControl, ,Edit1, %EditText%
  GuiControl, ,Button1, Update
Return

UpdateFile:
  DetectHiddenWindows On
  UpdateFile()
  ExitApp
Return

GuiSize:  ; Expand or shrink the ListView in response to the user's resizing of the window.
if A_EventInfo = 1  ; The window has been minimized.  No action needed.
    return
; Otherwise, the window has been resized or maximized. Resize the ListView to match.
GuiControl, Move, MyListView, % "W" . (A_GuiWidth - 20) . " H" . (A_GuiHeight - 40)
GuiControl, Move, Button1, % "y" . (A_GuiHeight - 30) 
GuiControl, Move, Edit1, % "y" . (A_GuiHeight - 30) . "W" . (A_GuiWidth - 90)
Return

UpdateFile()
  {
    FileDelete, ToDoList.txt
    WinGetPos, X, Y, Width, Height, To Do List
    Width -= 16
    Height -= 38
    FileAppend, x%x% y%y% w%Width% h%Height% `n, ToDoList.txt
    Loop % LV_GetCount()
     {
       Gui +LastFound
       SendMessage, 4140, A_Index - 1, 0xF000, SysListView321 
       IsChecked := (ErrorLevel >> 12) - 1
       If IsChecked
        {
          LV_GetText(Text, A_Index)
          FileAppend, *%Text% `n, ToDoList.txt
        }
         else
        {
          LV_GetText(Text, A_Index)
          FileAppend, %Text% `n, ToDoList.txt
        }
      }
   }


#IfWinActive, To Do List
^a::LV_Modify(0,"Select")
#IfWinActive