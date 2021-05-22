Gui, Add, ListView, gListCtrlEvent vMyFirstListView AltSubmit -ReadOnly R10 w310, ColumnTitle1|ColumnTitle2|ColumnTitle3
Gui, Add, ListView, gListCtrlEvent vMySecondListView AltSubmit -ReadOnly R10 w310, ColumnTitle1|ColumnTitle2|ColumnTitle3
Gui, Add, Text, w310, Action Log
Gui, Add, Edit, vLog R7 w310, 
Gui, Show,, Functions instead of labels

; Create example entries for the first ListView
Gui, ListView, MyFirstListView
Loop, 10 {
    LV_Add("", "Column-1 | Row-" A_Index ,  "Column-2 | Row-" A_Index,  "Column-3 | Row-" A_Index)
}
LV_ModifyCol()

; Create example entries for the second ListView
Gui, ListView, MySecondListView
Loop, 10 {
    LV_Add("", "Column-1 | Row-" A_Index ,  "Column-2 | Row-" A_Index,  "Column-3 | Row-" A_Index)
}
LV_ModifyCol()


ListCtrlEvent(ctrlHwnd:=0, guiEvent:="", eventInfo:="", errLvl:="") {
    GuiControlGet, ctrlName, Name, %CtrlHwnd%
    whatHappened := "Action detected!`n"
    whatHappened .= "Control handle: " ctrlHwnd "`n"
    whatHappened .= "Control name: " ctrlName "`n"
    
    If (guiEvent = "DoubleClick") {
        whatHappened .= "`nThe user has double-clicked within the control."
        whatHappened .= "`n> Focused row number: " eventInfo
    } Else If (guiEvent = "R") {
        whatHappened .= "`nThe user has double-right-clicked within the control."
        whatHappened .= "`n> Focused row number: " eventInfo
    } Else If (guiEvent = "ColClick") {
        whatHappened .= "`nThe user has clicked a column header."
        whatHappened .= "`n> Column number: " eventInfo
    } Else If (guiEvent = "D") {
        whatHappened .= "`nThe user has attempted to start dragging a row or icon."
        whatHappened .= "`n> Focused row number: " eventInfo
    } Else If (guiEvent = "d") {
        whatHappened .= "`nThe user has attempted to start right-click-dragging a row or icon."
        whatHappened .= "`n> Focused row number: " eventInfo
    } Else If (guiEvent = "e") {
        whatHappened .= "`nThe user has finished editing the first field of a row."
        whatHappened .= "`n> Row number: " eventInfo
    } Else If (guiEvent = "Normal") {
        whatHappened .= "`nThe user has left-clicked a row."
        whatHappened .= "`n> Focused row number: " eventInfo
    } Else If (guiEvent = "RightClick") {
        whatHappened .= "`nThe user has right-clicked a row."
        whatHappened .= "`n> Focused row number: " eventInfo
    } Else If (guiEvent = "A") {
        whatHappened .= "`nA row has been activated."
        whatHappened .= "`n> Row number: " eventInfo
    } Else If (guiEvent = "C") {
        whatHappened .= "`nThe ListView has released mouse capture."
    } Else If (guiEvent = "E") {
        whatHappened .= "`nThe user has begun editing the first field of a row."
        whatHappened .= "`n> Row number: " eventInfo
    } Else If (guiEvent = "F") {
        whatHappened .= "`nThe ListView has received keyboard focus."
    } Else If (guiEvent = "f") {
        whatHappened .= "`nThe ListView has lost keyboard focus."
    } Else If (guiEvent = "I") {
        whatHappened .= "`nItem changed. (A row has changed by becoming selected/deselected, checked/unchecked, etc.)"
        whatHappened .= "`n> Row number: " eventInfo
    } Else If (guiEvent = "K") {
        whatHappened .= "`nThe user has pressed a key while the ListView has focus."
        whatHappened .= "`n> Key pressed: " GetKeyName(Format("vk{:x}", eventInfo))
    } Else If (guiEvent = "M") {
        whatHappened .= "`nItem changed. (A row has changed by becoming selected/deselected, checked/unchecked, etc.)"
        whatHappened .= "`n> Row number: " eventInfo
    } Else If (guiEvent = "S") {
        whatHappened .= "`nMarquee. The user has started to drag a selection-rectangle around a group of rows or icons."
    } Else If (guiEvent = "s") {
        whatHappened .= "`nThe user has finished scrolling the ListView."
    }
    GuiControlGet, Log
    GuiControl,, Log, % whatHappened "`n---------------------`n" Log
}

GuiClose(hWnd) {
    WinGetTitle, windowTitle, ahk_id %hWnd%
    MsgBox, The Gui with title "%windowTitle%" is going to be closed! This script will exit afterwards!
    ExitApp
}