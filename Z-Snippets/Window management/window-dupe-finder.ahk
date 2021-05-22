;--------- create a few windows to act upon
f1::
title=Untitled - 

loop, 2
{
run, Notepad
sleep, 1000
send %a_index% ; <--- add a character to signify the order the window was created
}
return

;--------- count the windows and report the text in the body
f2::
WinGet, Var, List, %title%
k= >> %Var% windows `r`n
Loop %Var%
{
  Var := Var%A_Index%
  WinGetText, text, ahk_id %Var%
  WinGetTitle, Var, ahk_id %Var%
  k.= var "`r`n" text "`r`n" "`r`n"
  ;MsgBox % "The title of window " A_Index " is " Var "|" text
}
  MsgBox % k
return


+esc::exitapp	; to exit the script hit shift-escape