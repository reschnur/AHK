; Example: The following is a working script that monitors mouse clicks in a GUI window and displays where the mouse was clicked.
; Related topic: GuiContextMenu

Gui, Add, Text,, Click anywhere in this window.

Gui, Add, Edit, w200 vMyEdit

Gui, Show

OnMessage(0x201, "WM_LBUTTONDOWN")

return


WM_LBUTTONDOWN(wParam, lParam)
{
    X := lParam & 0xFFFF
    Y := lParam >> 16
    if A_GuiControl
	Control := "`n(in control " . A_GuiControl . ")"
    ToolTip You left-clicked in Gui window #%A_Gui% at client coordinates %X%x%Y%.%Control%
}

GuiEscape:
; Fall Thru

GuiClose:
ExitApp