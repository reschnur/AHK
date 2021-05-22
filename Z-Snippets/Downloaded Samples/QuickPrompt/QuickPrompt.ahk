;
; AutoHotkey Version: 1.x
; Language:       English
; Platform:       Win9x/NT
; Author:         A.N.Other <myemail@nowhere.com>
;
; Script Function:
;	Template script (you can customize this template by editing "ShellNew\Template.ahk" in your Windows folder)
;

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;___________________________________________
;______Easy Command Prompt  - Rajat_________

; Type '/' in the address bar of explorer window and type
; a DOS command to run it hidden.

; And to run it visibly and keep the command prompt
; window after that command, just use '//' instead of '/'



Hotkey, Enter, Prompt
Hotkey, Enter, Off
exit

~/::
	do = n
	ControlGetFocus, ctl, A
	IfWinActive, ahk_class CabinetWClass,, IfEqual, ctl, Edit1, setenv, do, y
	IfWinActive, ahk_class ExploreWClass,, IfEqual, ctl, Edit1, setenv, do, y
	IfEqual, do, n, Return
	
	WinGetActiveTitle, pth
	Hotkey, Enter, On
Return


Prompt:
	Hotkey, Enter, Off
	do = n
	ControlGetFocus, ctl, A
	IfWinActive, ahk_class CabinetWClass,, IfEqual, ctl, Edit1, setenv, do, y
	IfWinActive, ahk_class ExploreWClass,, IfEqual, ctl, Edit1, setenv, do, y
	IfEqual, do, n
	{
		Send, {Enter}
		Return
	}
	ControlGetText, cmd, Edit1, A
	StringLeft, check, cmd, 2
	IfEqual, check, //
	{
		StringTrimLeft, cmd, cmd, 2
		run, %comspec% /k %cmd%, %pth%
	}
	
	IfNotEqual, check, //
	{
		StringTrimLeft, cmd, cmd, 1
		run, %comspec% /c %cmd%, %pth%, hide
	}
	ControlSetText, Edit1, %pth%, %pth%
Return

