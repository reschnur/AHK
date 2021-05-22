Gui +OwnDialogs

; MsgBox, 16387, %Clipboard%, %CmdRef%

SetTimer, ChangeButtonNames, 50
OnMessage(0x53, "WM_HELP")
MsgBox, 16387,%Clipboard%
      , %CmdRef%`r`rClick "Load Page" to open AutoHotkey page
      .`r`rTickCount %ElapsedTime%


ChangeButtonNames: 
  IfWinNotExist, %clipboard%
    Return ; Keep waiting.
  SetTimer, ChangeButtonNames, off 
  WinActivate 
  ControlSetText, Button1, Load Page, %clipboard%
  ControlSetText, Button2, Insert Code, %clipboard%
  ControlSetText, Button3, Cancel, %clipboard%
  ControlSetText, Button4, Help, %clipboard%
Return