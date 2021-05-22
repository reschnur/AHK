; Not sure what this does. I need to watch the video again. 

#SingleInstance, Force

Gui, +AlwaysOnTop -Caption
Gui, Color, 00dc85

Gui, Add, Button, x100 w100 w100 h100 gGuiClose, Exit

Gui, Show, w500 h500, Mini Tut 22

OnMessage(0x201, "WM_LBUTTONDOWN")

Return

GuiEscape:

GuiClose:
ExitApp

WM_LBUTTONDOWN()
{
PostMessage, 0xA1, 2 ; 0xa1 = WM_NCLBUTTONDOWN

}