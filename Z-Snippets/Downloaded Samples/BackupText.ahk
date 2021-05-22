;
; AutoHotkey Version: 1.x
; Language:       English
; Platform:       Win9x/NT
; Author:         Jack Dunning https://jacksautohotkeyblog.wordpress.com/
;   AutoHotkey books available at http://www.computoredgebooks.com
;
; Script Function:
;	Saving text to C:\Users\%A_UserName%\Documents\SaveEdit.txt
;

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
;SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; Saving text to C:\Users\%A_UserName%\Documents\SaveEdit.txt with CTRL+ALT+B


^!B::
KeyWait, Control ; avoid sticky key  
KeyWait, Alt     ; avoid sticky key
KeyWait, b       ; avoid sticky key

  BlockInput, On ; turns off mouse and keyboard to prevent accidental deletion from input
    Send, ^a     ; select all
    Sleep, 100
    Send, ^c     ; copy selection to keyboard
    Sleep, 100
    Click        ; deselect all select
  BlockInput, Off

  IfExist, C:\Users\%A_UserName%\Documents\SaveEdit.txt
  {
    FileDelete, C:\Users\%A_UserName%\Documents\SaveEdit.txt   
  }
  FileAppend , %clipboard%, C:\Users\%A_UserName%\Documents\SaveEdit.txt

Return

